From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 11 Jun 2010 00:17:44 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <1275550613-9553-5-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
Message-ID: <AANLkTiltifSEFdpXB0avw4ZyDzP_IrDpipafBAJbN17U@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/3 Eric Miao <eric.miao@canonical.com>:

> +config ZRELADDR
> + ? ? ? hex "Physical address of the decompressed kernel image"
> + ? ? ? depends on !AUTO_ZRELADDR
> + ? ? ? default 0x00008000 if ARCH_BCMRING || ARCH_CNS3XXX || ARCH_DOVE ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_EBSA110 || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_IOP13XX || ARCH_IOP33X || ARCH_IXP2000 ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_IXP23XX || ARCH_IXP4XX || ARCH_KIRKWOOD ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_KS8695 ?|| ARCH_LOKI || ARCH_MMP || ARCH_MV78XX0 ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_NOMADIK || ARCH_NUC93X || ARCH_NS9XXX ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_ORION5X || ARCH_SPEAR3XX || ARCH_SPEAR6XX ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_UX5XX || ARCH_VERSATILE || ARCH_W90X900
> + ? ? ? default 0x08008000 if ARCH_MX1 || ARCH_SHARK
> + ? ? ? default 0x10008000 if ARCH_MSM || ARCH_OMAP1 || ARCH_RPC
> + ? ? ? default 0x20008000 if ARCH_S5P6440 || ARCH_S5P6442 ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_S5PC100 || ARCH_S5PV210
> + ? ? ? default 0x30008000 if ARCH_S3C2410 || ARCH_S3C2400 || ARCH_S3C2412 ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_S3C2416 || ARCH_S3C2440 || ARCH_S3C2443
> + ? ? ? default 0x40008000 if ARCH_STMP378X || ARCH_STMP37XX || ARCH_SH7372 ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_SH7377
> + ? ? ? default 0x50008000 if ARCH_S3C64XX || ARCH_SH7367
> + ? ? ? default 0x60008000 if ARCH_VEXPRESS
> + ? ? ? default 0x80008000 if ARCH_MX25 || ARCH_MX3 || ARCH_NETX ||\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARCH_OMAP2 || ARCH_PNX4008
> + ? ? ? default 0x90008000 if ARCH_MX5 || ARCH_MX91231
> + ? ? ? default 0xa0008000 if ARCH_IOP32X || ARCH_PXA || MACH_MX27
> + ? ? ? default 0xc0008000 if ARCH_LH7A40X || MACH_MX21
> + ? ? ? default 0xf0008000 if ARCH_AAEC2000 || ARCH_L7200
> + ? ? ? default 0xc0028000 if ARCH_CLPS711X
> + ? ? ? default 0x70008000 if ARCH_AT91 && (ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
> + ? ? ? default 0x20008000 if ARCH_AT91 && !(ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
> + ? ? ? default 0xc0008000 if ARCH_DAVINCI && ARCH_DAVINCI_DA8XX
> + ? ? ? default 0x80008000 if ARCH_DAVINCI && !ARCH_DAVINCI_DA8XX
> + ? ? ? default 0x00008000 if ARCH_EP93XX && EP93XX_SDCE3_SYNC_PHYS_OFFSET
> + ? ? ? default 0xc0008000 if ARCH_EP93XX && EP93XX_SDCE0_PHYS_OFFSET
> + ? ? ? default 0xd0008000 if ARCH_EP93XX && EP93XX_SDCE1_PHYS_OFFSET
> + ? ? ? default 0xe0008000 if ARCH_EP93XX && EP93XX_SDCE2_PHYS_OFFSET
> + ? ? ? default 0xf0008000 if ARCH_EP93XX && EP93XX_SDCE3_ASYNC_PHYS_OFFSET
> + ? ? ? default 0x00008000 if ARCH_GEMINI && GEMINI_MEM_SWAP
> + ? ? ? default 0x10008000 if ARCH_GEMINI && !GEMINI_MEM_SWAP
> + ? ? ? default 0x70008000 if ARCH_REALVIEW && REALVIEW_HIGH_PHYS_OFFSET
> + ? ? ? default 0x00008000 if ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET
> + ? ? ? default 0xc0208000 if ARCH_SA1100 && SA1111
> + ? ? ? default 0xc0008000 if ARCH_SA1100 && !SA1111
> + ? ? ? default 0x30108000 if ARCH_S3C2410 && PM_H1940
> + ? ? ? default 0x28E08000 if ARCH_U300 && MACH_U300_SINGLE_RAM
> + ? ? ? default 0x48008000 if ARCH_U300 && !MACH_U300_SINGLE_RAM

This looks correct so
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

I assume it should be submitted simultaneously with a patch nuking off
all Makefile.boot files and that infrastructure then?

Yours,
Linus Walleij
