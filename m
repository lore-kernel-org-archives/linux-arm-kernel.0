From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 14:38:32 +0000
Subject: [PATCH 10/16] drivers/gpio: represent gpio-nomadik as an IRQ
 controller in DT documentation
In-Reply-To: <1334659448-11521-11-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-11-git-send-email-lee.jones@linaro.org>
Message-ID: <201204171438.33051.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Lee Jones wrote:
> --- a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
> @@ -13,6 +13,7 @@ Required properties:
>                                    4 = active high level-sensitive.
>                                    8 = active low level-sensitive.
>  - gpio-controller       : Marks the device node as a GPIO controller.
> +- gpio-interrupt        : Marks the device node as a GPIO controller.
>  - gpio-bank             : Specifies which bank a controller owns.
>  - st,supports-sleepmode : Specifies whether controller can sleep or not
>  
> @@ -24,6 +25,7 @@ Example:
>                          interrupts = <0 120 0x4>;
>                          #gpio-cells = <2>;
>                          gpio-controller;
> +                        interrupt-controller;
>                          supports-sleepmode;
>                          gpio-bank = <1>;
>                  };

Documentation doesn't match the example or the code: it should be
'interrupt-controller' above, not 'gpio-interrupt'.

	Arnd
