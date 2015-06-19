From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jun 2015 12:41:00 +0900
Subject: [PATCH 00/15] ARM: shmobile: Remove legacy sh73a0/kzm9g and
 r8a7740/armadillo
In-Reply-To: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150619034052.GA22912@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ CC Linus, Laurent, linux-gpio ]

On Wed, Jun 17, 2015 at 11:31:16AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> The KZM-A9-GT and Armadillo-800 EVA boards are now sufficiently
> supported by DT-based and board-less SH-Mobile AG5 (sh73a0) and R-Mobile
> A1 (r8a7740) multi-platform kernels.
> 
> Lacking areas are:
>   - USB (it does't work in legacy, neither),
>   - HDMI on armadillo (it doesn't work in legacy, neither),
>   - Camera on armadillo (we don't care),
>   - LCDC:
>       - on armadillo, this is supported by the board staging code,
>       - on kzm9g, the LCDC is wired to the legacy INTC, which is not
> 	planned to be supported with DT,
>   - DMAC/IPMMU (no DT bindings are planned).
> 
> Hence this patch series removes legacy board and SoC code for
> sh73a0/kzm9g and r8a7740/armadillo.
> 
> It consists of 4 parts:
>   - Patches 1-4 remove legacy support for kzm9g (board code, defconfig,
>     dtb) and sh73a0,
>   - Patches 5-8 remove legacy support for armadillo (board code,
>     defconfig, dtb) and r8a7740,
>   - Patches 9-11 remove generic shmobile support code (dma-register.h,
>     legacy PM Domains, zboot) that became unused by the removal of
>     legacy sh73a0/kzm9g and r8a7740/armadillo,
>   - Patches 12-15 remove legacy sh73a0 and r8a7740 support in the
>     pinctrl drivers.
> 
> Dependencies:
>   - This is against next-20150617,
>   - To keep up with existing LCDC functionality for armadillo-legacy,
>     the r8a7740/armadillo part (and later parts) depends on "[PATCH v2
>     0/7] staging: board: armadillo800eva: Board staging for
>     sh_mobile_lcdc_fb" (https://lkml.org/lkml/2015/6/17/115).
>     However, it can be applied as-is now, and board staging can he
>     handled in parallel (if at all).
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (15):
>   ARM: shmobile: Remove legacy board code for KZM-A9-GT
>   ARM: shmobile: Remove legacy kzm9g_defconfig
>   ARM: shmobile: Drop sh73a0-kzm9g.dtb for legacy builds
>   ARM: shmobile: Remove legacy SoC code for SH-Mobile AG5
>   ARM: shmobile: Remove legacy board code for Armadillo-800 EVA
>   ARM: shmobile: Remove legacy armadillo800eva_defconfig
>   ARM: shmobile: Drop r8a7740-armadillo800eva.dtb for legacy builds
>   ARM: shmobile: Remove legacy SoC code for R-Mobile A1
>   ARM: shmobile: Remove unused dma-register.h
>   ARM: shmobile: R-Mobile: Remove legacy PM Domain code
>   ARM: shmobile: Remove obsolete zboot support

I have queued up the above patches for v4.3.

>   pinctrl: sh-pfc: sh73a0: Remove obsolete multi-platform check
>   pinctrl: sh-pfc: Remove obsolete sh73a0 platform_device_id entry
>   pinctrl: sh-pfc: r8a7740: Remove obsolete multi-platform check
>   pinctrl: sh-pfc: Remove obsolete r8a7740 platform_device_id entry

As the above patches are sh-pfc patches they would typically
be steered through Linus's tree via Laurent. If they wish
to take that path then I'm happy for this to be attached:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

FWIW the above path is the one that the removal of mackerel/sh7372 took.

Alternatively, I am happy to take the above sh-pfc patches through
my tree but I would like to do so with an Ack from at least Linus.
