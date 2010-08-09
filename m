From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Aug 2010 08:39:23 +0100
Subject: [PATCH] fix carelessly written Kconfig select statement
In-Reply-To: <AANLkTinAn_o7+AQzEk7V1vHzCFPPn6AVv=gMqCq7DDdH@mail.gmail.com>
References: <AANLkTinAn_o7+AQzEk7V1vHzCFPPn6AVv=gMqCq7DDdH@mail.gmail.com>
Message-ID: <20100809073923.GA9838@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 09:50:04AM +0800, eric.y.miao at gmail.com wrote:
> Any one found this?
> 
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 232f0c7..684c1a1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1184,8 +1184,8 @@ config LOCAL_TIMERS
>  		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
>  		ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_TEGRA)
>  	default y
> -	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
> -		ARCH_U8500 || ARCH_TEGRA
> +	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \
> +		ARCH_U8500 || ARCH_TEGRA)

Just get rid of the open paren - there's no reason for it to exist.
