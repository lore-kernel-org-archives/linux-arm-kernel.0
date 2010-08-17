From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 17 Aug 2010 11:04:22 +0530
Subject: [PATCH 0/3] SRAM map series
In-Reply-To: <1281262583-27392-1-git-send-email-santosh.shilimkar@ti.com>
References: <1281262583-27392-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C667B70E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony/Kevin,
> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Sunday, August 08, 2010 3:46 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Shilimkar, Santosh
> Subject: [PATCH 0/3] SRAM map series
> 
> Currently we map 1 MB section while setting up SRAM on OMAPs.
> The actual physcal OCM RAM available on OMAP SOCs is in order
> of KBs. On the newer ARMs with speculation, this is dangerous and can
> result in untraceable aborts.
> On Davinci as well because of section limitation the SRAM is
> marked as MT_DEVICE
> 
> First patch of this series addresses the section mapping limiaton and
> now we can map such memories as page level granularity.
> 
> The series is generated against latest manline commit "2d530569730"
> and boot tested on OMAP4430SDP, OMAP3430SDP platforms with
> omap_4430sdp_defconfig and multi-omap(omap3_defconfig) builds
> 
> Santosh Shilimkar (3):
>   ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED L1 entries
>   omap1/2/3/4: map only available SRAM
>   davinci: Map sram using MT_MEMORY_NONCACHED instead of MT_DEVICE
> 
Can you please have a look at second and third patch?
First patch is reviewed by Russell already

>  arch/arm/mach-davinci/dm355.c  |    3 +--
>  arch/arm/mach-davinci/dm365.c  |    3 +--
>  arch/arm/mach-davinci/dm644x.c |    3 +--
>  arch/arm/mach-davinci/dm646x.c |    3 +--
>  arch/arm/mm/mmu.c              |   18 ++++++++++++++++--
>  arch/arm/plat-omap/sram.c      |   25 +++++--------------------
>  6 files changed, 25 insertions(+), 30 deletions(-)
