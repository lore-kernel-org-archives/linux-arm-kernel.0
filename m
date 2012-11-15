From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 22:46:14 +0100
Subject: [PATCH 3/7] clk: armada-370-xp: add support for clock framework
In-Reply-To: <1353014906-31566-4-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
 <1353014906-31566-4-git-send-email-andrew@lunn.ch>
Message-ID: <20121115224614.2dfa7b88@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 15 Nov 2012 22:28:22 +0100, Andrew Lunn wrote:

> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 416d46e..e5f0ae2 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -9,11 +9,17 @@ config ARCH_MVEBU
>  	select PINCTRL
>  	select PLAT_ORION
>  	select SPARSE_IRQ
> +	select CLKDEV_LOOKUP
> +	select MVEBU_CLK_CORE
> +	select MVEBU_CLK_CPU
>  
>  if ARCH_MVEBU
>  
>  menu "Marvell SOC with device tree"
>  
> +config MVEBU_CLK_CPU
> +	   bool
> +

This config option is added to drivers/clk/mvebu/Kconfig in patch 2/7,
so I think it shouldn't be added here in patch 3/7.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
