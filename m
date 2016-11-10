From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 16:18:48 +0100
Subject: Summary of LPC guest MSI discussion in Santa Fe
In-Reply-To: <e59e9a17-e943-a227-5ea4-d028232155a8@arm.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
 <20161103220205.37715b49@t450s.home>
 <20161108024559.GA20591@arm.com> <20161108202922.GC15676@cbox>
 <20161108163508.1bcae0c2@t450s.home> <58228F71.6020108@redhat.com>
 <20161109170326.GG17771@arm.com> <582371FB.2040808@redhat.com>
 <e59e9a17-e943-a227-5ea4-d028232155a8@arm.com>
Message-ID: <20161110151848.GE2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 08:11:16PM +0000, Robin Murphy wrote:
> When we *are* in full control of the IOVA space, we just carve out what
> we can find as best we can - see iova_reserve_pci_windows() in
> dma-iommu.c, which isn't really all that different to what x86 does
> (e.g. init_reserved_iova_ranges() in amd-iommu.c).

Yeah, that code was actually written with a look at what the Intel
driver does. I don't really like that it goes over all resources and
reserves them individually (not only because it is not hotplug-safe).

I have to check whether there is a nice and generic way to find out the
root-bridge windows and just reserve them in the iova-space. That would
be easier and more reliable.


	Joerg
