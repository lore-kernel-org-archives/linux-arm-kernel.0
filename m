From: awg@embtoolkit.org (Abdoulaye Walsimou GAYE)
Date: Wed, 01 Jun 2011 14:13:35 +0200
Subject: [PATCH 0/3] Fixes for breakage resulting from syscore_ops patch
	on	s3c24xx
In-Reply-To: <201106011348.47145.heiko@sntech.de>
References: <201106011348.47145.heiko@sntech.de>
Message-ID: <4DE62CEF.80507@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> The syscore_ops patch from Rafael J. Wysocki introduced some small
> glitches for the S3C24XX cpus resulting in compile errors.
>
> Heiko Stuebner (3):
>    Fix missing struct for s3c2410_dma_chan in s3c2410_dma_suspend_chan
>    Move s3c24xx_irq_syscore_ops to plat-s3c24xx/irq.c
>    remove the now empty mach-s3c2410/irq.c
>
>   arch/arm/mach-s3c2410/Makefile |    1 -
>   arch/arm/mach-s3c2410/irq.c    |   34 ----------------------------------
>   arch/arm/plat-s3c24xx/dma.c    |    2 +-
>   arch/arm/plat-s3c24xx/irq.c    |    6 ++++++
>   4 files changed, 7 insertions(+), 36 deletions(-)
>   delete mode 100644 arch/arm/mach-s3c2410/irq.c
>    

I submitted same patches days ago [1], but without more explanations
than "ARM: s3c24xx: fix build errors introduced by bb072c3cf21d1", so

Acked-by : Abdoulaye Walsimou Gaye <awg@embtoolkit.org>

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/117812/focus=117814
