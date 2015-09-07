From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 7 Sep 2015 15:12:10 +0200
Subject: [PATCH 0/5] New Atmel PIO4 pinctrl/gpio driver
In-Reply-To: <1439281685-3020-1-git-send-email-ludovic.desroches@atmel.com>
References: <1439281685-3020-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150907131210.GC32379@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Any comments about this version? Maybe you missed it since you answered
me on the RFC version. Of course I'll do the changes you requested for
the next version (remove gpio_request_*() stuff and add macros for gpio
muxing case).

Thanks

Ludovic

On Tue, Aug 11, 2015 at 10:28:00AM +0200, Ludovic Desroches wrote:
> Hi,
> 
> The Atmel PIO4 controller has been introduced with SAMA5D2 chip family. This
> drivers manages both pinmux/pinconf and gpio stuff. It is inspired by Mediatek
> pinctrl driver.
> 
> Ludovic Desroches (5):
>   pinctrl: introduce driver for Atmel PIO4 controller
>   pinctrl: dt-binding: Add DT binding documentation for Atmel PIO4
>   MAINTAINERS: Add an entry for pinctrl-at91-pio4
>   ARM: at91/dt: sama5d2: add pio controller node
>   ARM: at91/defconfig: sama5: add PIO4 controller support
> 
>  .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |   90 ++
>  MAINTAINERS                                        |    7 +
>  arch/arm/boot/dts/sama5d2.dtsi                     |   14 +
>  arch/arm/mach-at91/Kconfig                         |    1 +
>  drivers/pinctrl/Kconfig                            |   13 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-at91-pio4.c                | 1063 ++++++++++++++++++++
>  7 files changed, 1189 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
>  create mode 100644 drivers/pinctrl/pinctrl-at91-pio4.c
> 
> -- 
> 2.5.0
> 
