From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Mar 2014 11:13:32 +0100
Subject: [PATCHv5 0/9] Device tree support for the at91sam9rlek
In-Reply-To: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5320334C.7060206@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2014 10:43, Alexandre Belloni :
> This series adds DT support for the at91sam9rl SoC, then the at91sam9rl-ek
> evaluation board.
> 
> While the at91sam9rl dtsi should be almost complete (still missing LCD and
> touchscreen bits). The at91sam9rlek DT now support the following tested
> features:
>  - MMC
>  - dbgu
>  - usart1
>  - watchdog
>  - nand
>  - leds
>  - buttons
>  - common clock framework
> 
> Next:
>  - spi
>  - dataflash
>  - i2c
>  - lcd
>  - touchscreen
>  - usb gadget
>  - audio
> 
> Changes since v4:
>  - correct a typo in the pwm clock name
>  - add an entry for the pwm clock in the board file lookup table
>  - reorder pinctrl nodes alphabetically
> 
> Changes since v3:
>  - reordered nand
>  - removed ADC and USB gadget definition as they were not working. They will
>    come with another set of patches adding proper support.
> 
> Alexandre Belloni (8):
>   ARM: at91: prepare at91sam9rl DT transition
>   ARM: at91: Add at91sam9rl DT SoC support
>   ARM: at91/defconfig: Add the sam9rl to the list of DT-enabled SOCs
>   ARM: at91: dt: sam9rl: Device Tree for the at91sam9rlek
>   ARM: at91: prepare common clk transition for sam9rl SoCs
>   ARM: at91/dt: define at91sam9rl clocks
>   ARM: at91/dt: define main clk frequency of at91sam9rlek
>   ARM: at91: switch sam9rl to common clock framework
> 
> Boris BREZILLON (1):
>   ARM: at91: prepare sam9 dt boards transition to common clk

The series seems ready for inclusion. I stack the whole series on our
at91-3.15-cleanup branch with my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks a lot.


>  arch/arm/boot/dts/Makefile         |   2 +
>  arch/arm/boot/dts/at91sam9rl.dtsi  | 802 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9rlek.dts | 157 ++++++++
>  arch/arm/configs/at91_dt_defconfig |   1 +
>  arch/arm/mach-at91/Kconfig         |   1 -
>  arch/arm/mach-at91/at91sam9rl.c    |  23 +-
>  arch/arm/mach-at91/board-dt-sam9.c |  11 +-
>  7 files changed, 994 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91sam9rl.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9rlek.dts
> 


-- 
Nicolas Ferre
