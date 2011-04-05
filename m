From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 5 Apr 2011 14:12:13 -0700
Subject: [PATCH] ARM: tegra: harmony: Register and configure WM8903 IRQ
	GPIO
In-Reply-To: <1299875143-19096-1-git-send-email-swarren@nvidia.com>
References: <1299875143-19096-1-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3594@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Friday, March 11, 2011 1:26 PM:
> Technically, we need to request and configure the GPIO used as the WM8903
> interrupt. This prevents conflicting registrations, and assures that the
> GPIO is correctly configured in all cases, e.g. if the bootloader left the
> GPIO in some unexpected state.
> 
> In practice, the previous code works as-is, at least when using ChromeOS's
> U-Boot as the boot-loader.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Olof,

I think this patch got missed. It's not especially important in practice,
but the code may as well be complete.

Thanks.

> ---
>  arch/arm/mach-tegra/board-harmony.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-
> tegra/board-harmony.c
> index e7c2fea..91178a6 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -130,6 +130,9 @@ static void __init harmony_i2c_init(void)
>  	platform_device_register(&tegra_i2c_device3);
>  	platform_device_register(&tegra_i2c_device4);
> 
> +	gpio_request(TEGRA_GPIO_CDC_IRQ, "wm8903");
> +	gpio_direction_input(TEGRA_GPIO_CDC_IRQ);
> +
>  	i2c_register_board_info(0, &wm8903_board_info, 1);
>  }
> 
> --
> 1.7.1

-- 
nvpublic
