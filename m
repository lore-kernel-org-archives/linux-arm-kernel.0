From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Wed, 6 Feb 2013 11:08:27 +0900
Subject: [PATCH v5 1/3] ARM: vmregion: remove vmregion code entirely
In-Reply-To: <5110C857.6050100@ti.com>
References: <1360024314-1895-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1360024314-1895-2-git-send-email-iamjoonsoo.kim@lge.com>
 <5110C857.6050100@ti.com>
Message-ID: <20130206020827.GC4325@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Santosh.

On Tue, Feb 05, 2013 at 02:22:39PM +0530, Santosh Shilimkar wrote:
> On Tuesday 05 February 2013 06:01 AM, Joonsoo Kim wrote:
> >Now, there is no user for vmregion.
> >So remove it.
> >
> >Acked-by: Nicolas Pitre <nico@linaro.org>
> >Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> >diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> >index 8a9c4cb..4e333fa 100644
> >--- a/arch/arm/mm/Makefile
> >+++ b/arch/arm/mm/Makefile
> >@@ -6,7 +6,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
> >  				   iomap.o
> >
> >  obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
> >-				   mmap.o pgd.o mmu.o vmregion.o
> >+				   mmap.o pgd.o mmu.o
> >
> >  ifneq ($(CONFIG_MMU),y)
> >  obj-y				+= nommu.o
> >diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
> >deleted file mode 100644
> >index a631016..0000000
> >--- a/arch/arm/mm/vmregion.c
> >+++ /dev/null
> >@@ -1,205 +0,0 @@
> You might want to use 'git format-patch -D'
> which will just generate one line for a deleted file.

Nice tip!
Thanks.

> Regards,
> Santosh
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
