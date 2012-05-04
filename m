From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 5 May 2012 01:28:57 +0530
Subject: [PATCH 02/15] ARM: davinci: use machine specific hook for late
 init
In-Reply-To: <1335958420-5193-3-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <1335958420-5193-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FA43501.6020605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 5/2/2012 5:03 PM, Shawn Guo wrote:
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index d72ab94..f213359 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -798,6 +798,7 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
>  	.init_irq     = davinci_irq_init,
>  	.timer        = &davinci_timer,
>  	.init_machine = evm_init,
> +	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
>  	.restart	= davinci_restart,
>  MACHINE_END

There is another machine defined in the board-dm646x-evm.c file which
needs to be updated too. You can apply the following diff.

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c
b/arch/arm/mach-davinci/board-dm646x-index f213359..958679a 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -788,6 +788,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
        .init_irq     = davinci_irq_init,
        .timer        = &davinci_timer,
        .init_machine = evm_init,
+       .init_late      = davinci_init_late,
        .dma_zone_size  = SZ_128M,
        .restart        = davinci_restart,
 MACHINE_END

With this fixed, please also add my:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
