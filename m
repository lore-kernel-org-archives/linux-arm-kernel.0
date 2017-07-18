From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 18 Jul 2017 14:51:09 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_UNIPHIER_WATCHDOG
In-Reply-To: <1500355472-27521-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1500355472-27521-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <CAK7LNAQiUn_NbFAbf4jQuhXGk7CXw4hBDimWTi_hNh4x0MPiPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-07-18 14:24 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> Enable the watchdog driver for UniPhier SoC
>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6c7d147..5d204a4 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -310,6 +310,7 @@ CONFIG_WATCHDOG=y
>  CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_MESON_GXBB_WATCHDOG=m
>  CONFIG_MESON_WATCHDOG=m
> +CONFIG_UNIPHIER_WATCHDOG=y
>  CONFIG_RENESAS_WDT=y
>  CONFIG_BCM2835_WDT=y
>  CONFIG_MFD_CROS_EC=y


Please add CONFIG_UNIPHIER_WATCHDOG=y
below CONFIG_RENESAS_WDT=y

It is the order preferred by "make savedefconfig".
