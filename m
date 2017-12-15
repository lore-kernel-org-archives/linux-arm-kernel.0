From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Dec 2017 16:33:47 +0100
Subject: [PATCH] arm64: rockchip: enable Rockchip IO domain support
In-Reply-To: <20171215122010.34160-1-klaus.goger@theobroma-systems.com>
References: <20171215122010.34160-1-klaus.goger@theobroma-systems.com>
Message-ID: <2479039.bQBttOkD7L@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Dezember 2017, 13:20:10 CET schrieb Klaus Goger:
> Make sure the IO domain support is active. This requires to enable
> Adaptive Voltage Scaling class support too.
> 
> Without Rockchip IO domain support the internal level shifter on the RK3399
> will be misconfigured if used in the other voltage domain then the default.
> 
> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
> 
> ---
> 
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 2401373565ff..7c0b0ab12f18 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -150,6 +150,8 @@ config ARCH_ROCKCHIP
>  	select GPIOLIB
>  	select PINCTRL
>  	select PINCTRL_ROCKCHIP
> +	select POWER_AVS
> +	select ROCKCHIP_IODOMAIN

I'm not sure if we really want this in the default arch Kconfig or if there
are cases where the iodomain driver is not necessary.

On arm32 it just gets selected in the regular defconfig [0]


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/configs/multi_v7_defconfig#n452
