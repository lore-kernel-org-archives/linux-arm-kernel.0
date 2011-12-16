From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 Dec 2011 19:53:43 -0600
Subject: [PATCH 0/6] ARM: at91: irqdomain and device tree for AIC and GPIO
In-Reply-To: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4EEAA4A7.3040902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On 12/15/2011 01:16 PM, Nicolas Ferre wrote:
> Hi,
> 
> This series adds irqdomain and device tree support for both the
> interrupt and GPIO controllers of AT91 SoC.
> 
> The AIC part has already been sent some time ago but has been
> reworked to address Rob's comments. This reworked patch is marked
> with a "v4" tag.
> 
> The series can go on top of Jamie's patch
> "irqdomain: export irq_domain_simple_ops for !CONFIG_OF"
> and has been tested on top of 'v3.2-rc5' + 'arm-soc/at91/ioremap'
> and 'arm-soc/at91/gpio'
> 
> Jean-Christophe PLAGNIOL-VILLARD (1):
>       ARM: at91/gpio: add DT support
> 
> Nicolas Ferre (5):
>       ARM: at91/aic: add irq domain and device tree support
>       ARM: at91/gpio: add irqdomain to gpio interrupts
>       ARM: at91/gpio: add .to_irq gpio_chip handler and rework irq_to_gpio
>       ARM: at91/gpio: remove the static specification of gpio_chip.base
>       ARM: at91/board-dt: remove AIC irq domain from board file
> 
>  .../devicetree/bindings/arm/atmel-aic.txt          |   38 ++++
>  .../devicetree/bindings/gpio/gpio_at91.txt         |   20 ++
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/at91sam9g20.dtsi                 |   44 ++++-
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |   59 +++++-
>  arch/arm/mach-at91/board-dt.c                      |   15 +--
>  arch/arm/mach-at91/gpio.c                          |  197 ++++++++++++++++----
>  arch/arm/mach-at91/include/mach/gpio.h             |   12 --
>  arch/arm/mach-at91/include/mach/irqs.h             |    3 +-
>  arch/arm/mach-at91/irq.c                           |   91 +++++++--
>  10 files changed, 383 insertions(+), 97 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/atmel-aic.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_at91.txt

What about using generic irq chip as I previously mentioned? It looks to
me like both the AIC and gpio controller could use it. I've added irq
domain support to generic irq chip, so it should simplify your changes.
The latest branch is here:

git://sources.calxeda.com/kernel/linux.git pl061-domain-v2

Rob
