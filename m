From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 16:07:51 -0700
Subject: [PATCH-V3 3/4] arm:omap:am33xx: Create board support and
	enable build for AM335XEVM
In-Reply-To: <1316529142-27564-4-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-4-git-send-email-hvaibhav@ti.com>
Message-ID: <20111006230751.GZ6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* hvaibhav at ti.com <hvaibhav@ti.com> [110920 06:59]:
> From: Afzal Mohammed <afzal@ti.com>
> 
> This patch adds minimal support and build configuration for
> AM335X EVM.
...

> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-am335xevm.c
> +
> +MACHINE_START(AM335XEVM, "am335xevm")
> +	/* Maintainer: Texas Instruments */
> +	.boot_params	= 0x80000100,
> +	.map_io		= am335x_evm_map_io,
> +	.init_early	= am335x_init_early,
> +	.init_irq	= ti816x_init_irq,
> +	.timer		= &omap3_timer,
> +	.init_machine	= am335x_evm_init,
> +MACHINE_END

Please just add the support into board-am3517evm.c, the board-*.c
files will be going away with device tree.

Regards,

Tony
