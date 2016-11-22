From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 09:45:35 +0100
Subject: [PATCH 1/6] reset: hisilicon: add reset core
In-Reply-To: <1479800961-6249-2-git-send-email-zhangfei.gao@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <1479800961-6249-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <3993565.nedzUBZcVS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 3:49:16 PM CET Zhangfei Gao wrote:
> @@ -1,8 +1,8 @@
>  obj-y += core.o
> -obj-y += hisilicon/
>  obj-$(CONFIG_ARCH_STI) += sti/
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_ARCH_HISI) += hisilicon/
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o

Please leave the obj-y line, otherwise the COMPILE_TEST variant won't work.

	Arnd
