From: ido@wizery.com (Ido Yariv)
Date: Sun, 30 Sep 2012 13:04:09 -0400
Subject: [PATCH 2/3] iommu/omap: Merge iommu2.h into iommu.h
In-Reply-To: <20120927195526.GP4840@atomide.com>
References: <1348204448-30855-1-git-send-email-ido@wizery.com>
 <1348204448-30855-2-git-send-email-ido@wizery.com>
 <20120927195313.GO4840@atomide.com>
 <20120927195526.GP4840@atomide.com>
Message-ID: <20120930170408.GA5745@NoteStation.RenaNet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 12:55:26PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120927 12:54]:
> > Hi Ido,
> > 
> > * Ido Yariv <ido@wizery.com> [120920 22:15]:
> > > Since iommu is not currently supported on OMAP1, merge plat/iommu2.h into
> > > iommu.h so only one file would have to move to platform_data/ as part of the
> > > single zImage effort.
> > 
> > Looks like you need patch 2.5/3 in this series too that
> > makes some of the things defined in iommu.h local.
> > 
> > We should only have platform data in include/linux/platform_data,
> > so things that are private to drivers should be defined in the
> > driver, and things that are private to arch/arm/mach-omap2 should
> > defined locally there.
> > 
> > Based on a quick grepping of files, looks like these should be
> > defined in omap-iommu.c driver and not in the platform_data header:
> > 
> > struct iotlb_lock
> > struct iotlb_lock
> > dev_to_omap_iommu
> > various register defines
> > omap_iommu_arch_version
> > omap_iotlb_cr_to_e
> > omap_iopgtable_store_entry
> > omap_iommu_save_ctx
> > omap_iommu_restore_ctx
> > omap_foreach_iommu_device
> > omap_iommu_dump_ctx
> > omap_dump_tlb_entries
> 
> And looks like while at it, you can also move plat/iopgtable.h
> and put it in some drivers/iommu/*.h file that's shared by
> omap-iommu*.c and omap-iovmm.c drivers ;)

Sure thing, I'll post a v2 shortly.

Thanks,
Ido.
