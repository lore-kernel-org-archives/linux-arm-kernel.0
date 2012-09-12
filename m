From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 12 Sep 2012 16:34:16 +0000 (UTC)
Subject: [PATCH v9 3/3] ARM: OMAP2+: gpmc: minimal driver support
In-Reply-To: <35901c3137e42170066f3efb5026b0749ccdcbb5.1347355380.git.afzal@ti.com>
References: <cover.1347355380.git.afzal@ti.com>
 <35901c3137e42170066f3efb5026b0749ccdcbb5.1347355380.git.afzal@ti.com>
Message-ID: <alpine.DEB.2.00.1209121631440.17903@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 11 Sep 2012, Afzal Mohammed wrote:

> Create a minimal driver out of gpmc code.
> Responsibilities handled by earlier gpmc
> initialization is now achieved in probe.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Two checkpatch warnings are added by this patch:

CHECK: multiple assignments should be avoided
#77: FILE: arch/arm/mach-omap2/gpmc.c:454:
+	res->start = res->end = 0;

CHECK: Alignment should match open parenthesis
#216: FILE: arch/arm/mach-omap2/gpmc.c:936:
+	dev_info(gpmc_dev, "GPMC revision %d.%d\n",
+				GPMC_REVISION_MAJOR(l), GPMC_REVISION_MINOR(l));

I've fixed them here in the obvious way.  But please make sure that all 
your patches are clean with 'checkpatch.pl --strict'; saves us time and 
frustration...


- Paul
