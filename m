From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 05 Aug 2016 11:06:28 +0200
Subject: [PATCH v3] reset: uniphier: add reset controller driver for
 UniPhier SoCs
In-Reply-To: <1470111510-21247-1-git-send-email-yamada.masahiro@socionext.com>
References: <1470111510-21247-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1470387988.3141.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 02.08.2016, 13:18 +0900 schrieb Masahiro Yamada:
> This is the initial commit for UniPhier reset controller driver.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[...]
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_MESON) += reset-meson.o
>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_ARCH_STI) += sti/
>  obj-$(CONFIG_ARCH_HISI) += hisilicon/
> +obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>  obj-$(CONFIG_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o

Thank you, I have applied this patch with one small change: The Makefile
change is moved after TI_SYSCON_RESET, like you did in the Kconfig, to
keep the non-arch symbols in alphabetic order.

regards
Philipp
