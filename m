From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 5 Feb 2013 14:22:39 +0530
Subject: [PATCH v5 1/3] ARM: vmregion: remove vmregion code entirely
In-Reply-To: <1360024314-1895-2-git-send-email-iamjoonsoo.kim@lge.com>
References: <1360024314-1895-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1360024314-1895-2-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <5110C857.6050100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013 06:01 AM, Joonsoo Kim wrote:
> Now, there is no user for vmregion.
> So remove it.
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> index 8a9c4cb..4e333fa 100644
> --- a/arch/arm/mm/Makefile
> +++ b/arch/arm/mm/Makefile
> @@ -6,7 +6,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
>   				   iomap.o
>
>   obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
> -				   mmap.o pgd.o mmu.o vmregion.o
> +				   mmap.o pgd.o mmu.o
>
>   ifneq ($(CONFIG_MMU),y)
>   obj-y				+= nommu.o
> diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
> deleted file mode 100644
> index a631016..0000000
> --- a/arch/arm/mm/vmregion.c
> +++ /dev/null
> @@ -1,205 +0,0 @@
You might want to use 'git format-patch -D'
which will just generate one line for a deleted file.

Regards,
Santosh
