From: ilias.apalodimas@linaro.org (Ilias Apalodimas)
Date: Fri, 25 May 2018 09:33:11 +0300
Subject: [PATCH v2 03/40] iommu/sva: Manage process address spaces
In-Reply-To: <19e82a74-429a-3f86-119e-32b12082d0ff@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <20180516163117.622693ea@jacob-builder>
 <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
 <20180522094334.71f0e36b@jacob-builder>
 <f73b4a0e-669e-8483-88d7-1b2c8a2b9934@arm.com>
 <20180524115039.GA10260@apalos>
 <19e82a74-429a-3f86-119e-32b12082d0ff@arm.com>
Message-ID: <20180525063311.GA11605@apalos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 04:04:39PM +0100, Jean-Philippe Brucker wrote:
> On 24/05/18 12:50, Ilias Apalodimas wrote:
> >> Interesting, I hadn't thought about this use-case before. At first I
> >> thought you were talking about mdev devices assigned to VMs, but I think
> >> you're referring to mdevs assigned to userspace drivers instead? Out of
> >> curiosity, is it only theoretical or does someone actually need this?
> > 
> > There has been some non upstreamed efforts to have mdev and produce userspace
> > drivers. Huawei is using it on what they call "wrapdrive" for crypto devices and
> > we did a proof of concept for ethernet interfaces. At the time we choose not to
> > involve the IOMMU for the reason you mentioned, but having it there would be
> > good.
> 
> I'm guessing there were good reasons to do it that way but I wonder, is
> it not simpler to just have the kernel driver create a /dev/foo, with a
> standard ioctl/mmap/poll interface? Here VFIO adds a layer of
> indirection, and since the mediating driver has to implement these
> operations already, what is gained?
The best reason i can come up with is "common code". You already have one API
doing that for you so we replicate it in a /dev file?
The mdev approach still needs extentions to support what we tried to do (i.e
mdev bus might need yo have access on iommu_ops), but as far as i undestand it's
a possible case.
> 
> Thanks,
> Jean
