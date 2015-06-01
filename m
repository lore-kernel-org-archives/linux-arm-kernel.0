From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jun 2015 13:52:53 -0300
Subject: [GIT PULL 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <3918834.Y7ttkc5iBm@wuerfel>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
 <1433145206-2508-3-git-send-email-shawn.guo@linaro.org>
 <3918834.Y7ttkc5iBm@wuerfel>
Message-ID: <CAOMZO5Co4w7AU7xLP1yq5gqkO0H8RdkxGSvoK-=62m62LEDkJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jun 1, 2015 at 1:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Hi Shawn,
>
> If it's not too much of a hassle, could you rebase the soc and dt branches,
> so that only the addition of the dt-bindings header is shared between
> them, rather than the whole imx/soc branch?
>
> Also, could you fold this change into the patch that moves the gpt driver?
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 3c15a49fdac9..fd43dbb5e47b 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -278,7 +278,7 @@ config CLKSRC_PXA
>
>  config CLKSRC_IMX_GPT
>         bool "Clocksource using i.MX GPT" if COMPILE_TEST
> -       depends on OF
> +       depends on OF && COMMON_CLK
>         select CLKSRC_MMIO
>
>  config H8300_TMR16
>
> Without this, we get build errors for COMPILE_TEST.

Shouldn't it be like this instead?

--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -278,7 +278,7 @@ config CLKSRC_PXA

 config CLKSRC_IMX_GPT
        bool "Clocksource using i.MX GPT" if COMPILE_TEST
-       depends on OF
+       select CLKSRC_OF if OF
        select CLKSRC_MMIO
