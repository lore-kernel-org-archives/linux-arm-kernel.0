From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 13 Sep 2011 12:44:33 +0200
Subject: [PATCH 3/3] iommu/core: split mapping to page sizes as supported
	by the hardware
In-Reply-To: <CAK=WgbbhdFpAHTt=Bku-v1ZOCf48+u+XB-f4yO=5EDojv1kCJg@mail.gmail.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
	<1315421604-12286-3-git-send-email-ohad@wizery.com>
	<20110913101011.GK11701@amd.com>
	<CAK=WgbbhdFpAHTt=Bku-v1ZOCf48+u+XB-f4yO=5EDojv1kCJg@mail.gmail.com>
Message-ID: <20110913104433.GL11701@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 06:34:23AM -0400, Ohad Ben-Cohen wrote:
> Hi Joerg,
> 
> On Tue, Sep 13, 2011 at 1:10 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> > Please split this patch into the core-change and patches for the
> > individual iommu-drivers and post this as a seperate patch-set.
> 
> But we'll be breaking bisectibility this way, no?

Not necessarily. You could implement this side-by-side with the old code
until all drivers are converted and remove the old code then. This keeps
bisectability.

> > Intel IOMMU does not support arbitrary page-sizes, afaik.
> 
> It does; besides the usual 4K it has "super page sizes" support of
> 2MB, 1GB, 512GB and 1TB.

But the value ~0xfffUL indicates support for 4k, 8k, 16k .. 2^63, no?

> 
> >> + ? ? ? pr_debug("map: iova 0x%lx pa 0x%lx size 0x%lx\n", iova,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (unsigned long)paddr, size);
> >
> > Please keep the debug-code in a seperate patch in your dev-tree. No need
> > for it to be merged upstream.
> 
> It's actually useful sometimes to have those around - it's off by
> default, and can be enabled only when needed (CONFIG_DYNAMIC_DEBUG).
> 
> But I don't mind removing them.

Ah right, it is just debug, so I am fine keeping it.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
