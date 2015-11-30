From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 10:34:23 -0800
Subject: [PATCH 0/4] Cleanup legacy OMAP IOMMU device creation
In-Reply-To: <562919CB.1000606@ti.com>
References: <1442447302-5246-1-git-send-email-s-anna@ti.com>
 <562919CB.1000606@ti.com>
Message-ID: <20151130183423.GJ2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [151022 10:16]:
> Hi Tony,
> 
> On 09/16/2015 06:48 PM, Suman Anna wrote:
> > Hi Tony,
> > 
> > The following series removes the legacy platform device creation
> > logic for OMAP IOMMU devices. I will cleanup the legacy support
> > from the OMAP IOMMU driver in a subsequent merge window after
> > this series makes it to mainline.
> > 
> > Patches are based on 4.3-rc1 + the OMAP3 ISP instantiation cleanup
> > patch [1]. All the patches need to be picked up sequentially,
> > otherwise a NULL pointer dereference crash might be seen on OMAP3
> > legacy boots as the dev attribute structure is deferenced directly
> > in mach-omap2/omap-iommu.c during platform data creation. Also, the
> > last patch removes the structure definition altogether, so will
> > cause build issues if picked separately from the hwmod cleanup
> > patches.
> > 
> > I do not have any boards where I can still perform a legacy-style
> > boot, so patches verified using DT-boot only.
> > 
> > regards
> > Suman
> > 
> > [1] https://patchwork.kernel.org/patch/6806891/
> > 
> > Suman Anna (4):
> >   ARM: OMAP2+: Remove legacy device instantiation of IOMMUs
> >   ARM: OMAP3: hwmod data: Remove legacy IOMMU data
> >   ARM: OMAP4: hwmod data: Remove legacy IOMMU attr and addrs
> >   ARM: OMAP2+: Remove omap_mmu_dev_attr structure
> 
> Ping on this series. You should be able to pick up atleast patch 1 if
> not picking all, now that the OMAP3 ISP cleanup patch is staged in your
> omap-for-4.4/cleanup branch.

Sorry for the delays, applying this series into omap-for-v4.5/soc.

Regards,

Tony
