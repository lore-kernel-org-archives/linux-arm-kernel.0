From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Aug 2012 10:01:26 -0300
Subject: [PATCH 6/6] ARM: imx: gpmi-nand depends on mxs-dma
In-Reply-To: <1344430493-5304-7-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-7-git-send-email-arnd@arndb.de>
Message-ID: <CAOMZO5CZ7mJd89cN_S0KBS74mc5qTzvrfRbmHVX3nmEakx19ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Aug 8, 2012 at 9:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> It is not currently possible to build the gpmi-nand driver without
> also building the mxs-dma driver. Clarify this Kconfig and enable
> both in the defconfig file so we can build it again with both enabled.
>
> drivers/built-in.o: In function `gpmi_dma_filter':
> clk-fixed-factor.c:(.text+0xafc18): undefined reference to `mxs_dma_is_apbh'
> make[1]: *** [vmlinux] Error 1
> make: *** [sub-make] Error 2
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>

I have already sent a fix for this to the mtd list:
https://patchwork.kernel.org/patch/1236551/

Regards,

Fabio Estevam
