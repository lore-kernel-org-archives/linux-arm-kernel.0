From: yamada.masahiro@socionext.com (yamada.masahiro at socionext.com)
Date: Fri, 6 Apr 2018 05:31:26 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and
 CONFIG_SNI_AVE
In-Reply-To: <1522153269-21244-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522153269-21244-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <243c6f13b7264e7881b5b06a9c8dca30@SOC-EX01V.e01.socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Kunihiko Hayashi [mailto:hayashi.kunihiko at socionext.com]
> Sent: Tuesday, March 27, 2018 9:21 PM
> To: Russell King <linux@armlinux.org.uk>; Yamada, Masahiro/?? ??
> <yamada.masahiro@socionext.com>; Olof Johansson <olof@lixom.net>; Arnd
> Bergmann <arnd@arndb.de>; linux-arm-kernel at lists.infradead.org
> Cc: arm at kernel.org; Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi
> Brar <jaswinder.singh@linaro.org>; Hayashi, Kunihiko/? ??
> <hayashi.kunihiko@socionext.com>
> Subject: [PATCH] ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and
> CONFIG_SNI_AVE
> 
> Enable the thermal monitor driver and the AVE ethernet driver
> implemented on UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>


What has happened to this patch?

You picked up arch/arm64/config/defconfig one (commit d28db34a),
but I am afraid you missed this one (arch/arm/configs/multi_v7_defconfig).

I do not have a strong opinion whether ethernet drivers should be built-in or modular,
but I want to see consistency between arch/arm and arch/arm64
for Socionext platform.

You accepted commit d28db34a anyway,
so I hope you will pick up this one too.


BTW, I do not see this patch in any ML at all.
Probably, the sender of this patch, Kunihiko Hayashi,
is not a subscriber of the ARM-linux ML, and he did not CC LKML either.



> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig
> index c1e045a..8c923ec 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -262,6 +262,7 @@ CONFIG_KS8851=y
>  CONFIG_R8169=y
>  CONFIG_SH_ETH=y
>  CONFIG_SMSC911X=y
> +CONFIG_SNI_AVE=y
>  CONFIG_STMMAC_ETH=y
>  CONFIG_STMMAC_PLATFORM=y
>  CONFIG_DWMAC_DWC_QOS_ETH=y
> @@ -479,6 +480,7 @@ CONFIG_ARMADA_THERMAL=y
>  CONFIG_DAVINCI_WATCHDOG=m
>  CONFIG_EXYNOS_THERMAL=m
>  CONFIG_ST_THERMAL_MEMMAP=y
> +CONFIG_UNIPHIER_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_DA9063_WATCHDOG=m
>  CONFIG_XILINX_WATCHDOG=y
> --
> 2.7.4
