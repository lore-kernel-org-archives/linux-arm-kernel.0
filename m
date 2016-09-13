From: joel@jms.id.au (Joel Stanley)
Date: Tue, 13 Sep 2016 22:13:38 +0930
Subject: [PATCH v3 2/7] mach-aspeed: Select GPIO driver
In-Reply-To: <20160830075600.11559-3-andrew@aj.id.au>
References: <20160830075600.11559-1-andrew@aj.id.au>
 <20160830075600.11559-3-andrew@aj.id.au>
Message-ID: <CACPK8XdM2Q_DdO7vat+QASxFJht7dYZQautZROE8D3zuT3qXWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 5:25 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index f3f8c5c658db..5aba9598f821 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -7,6 +7,8 @@ menuconfig ARCH_ASPEED
>         select MOXART_TIMER
>         select MFD_SYSCON
>         select PINCTRL
> +       select GPIOLIB
> +       select GPIO_ASPEED

GPIO_ASPEED is a tristate, so if we select it in ARCH_ASPEED all users
of the driver will have it selected.

I think I will drop this patch so we still have the option of building
the gpio driver as a module. Otherwise, we should change the GPIO
driver to be built in.

Cheers,

Joel
