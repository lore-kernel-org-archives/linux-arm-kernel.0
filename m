From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 20:08:27 +0200
Subject: [GIT PULL 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <CAOMZO5Co4w7AU7xLP1yq5gqkO0H8RdkxGSvoK-=62m62LEDkJg@mail.gmail.com>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
 <3918834.Y7ttkc5iBm@wuerfel>
 <CAOMZO5Co4w7AU7xLP1yq5gqkO0H8RdkxGSvoK-=62m62LEDkJg@mail.gmail.com>
Message-ID: <2377672.jjB42yabec@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 13:52:53 Fabio Estevam wrote:
> 
> Shouldn't it be like this instead?
> 
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -278,7 +278,7 @@ config CLKSRC_PXA
> 
>  config CLKSRC_IMX_GPT
>         bool "Clocksource using i.MX GPT" if COMPILE_TEST
> -       depends on OF
> +       select CLKSRC_OF if OF
>         select CLKSRC_MMIO

Yes, that's better than my approach. Thanks for taking a closer look!

	Arnd
