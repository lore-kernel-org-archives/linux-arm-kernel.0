From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 15 Aug 2017 09:20:00 -0700
Subject: [PATCH 0/8] MIPS: BCM63XX: add and use clkdev lookup support
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Message-ID: <b180fcb8-0282-3bad-aad0-4f1faaea73b0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/2017 02:34 AM, Jonas Gorski wrote:
> This patchset adds and uses clckdev lookup support to name input clocks
> in various drivers more closely to their functions, or simplify their
> usage.
> 
> Since most of these patches touch arch/mips, it probably makes most
> sense to go through the MIPS tree.
> 
> The HSSPI driver was already updated previously to support a "pll"
> input with ff18e1ef04e2 ("spi/bcm63xx-hsspi: allow providing clock rate
> through a second clock"), so there is no need to touch it.
> 
> This patch series is part of an effort to modernize BCM63XX and clean up
> its drivers to eventually make them usable with BMIPS and device tree.

For this entire series:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> 
> Jonas Gorski (8):
>   MIPS: BCM63XX: add clkdev lookup support
>   MIPS: BCM63XX: provide periph clock as refclk for uart
>   tty/bcm63xx_uart: use refclk for the expected clock name
>   tty/bcm63xx_uart: allow naming clock in device tree
>   MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
>   bcm63xx_enet: just use "enet" as the clock name
>   MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
>   MIPS: BMIPS: name the refclk clock for uart
> 
>  .../bindings/serial/brcm,bcm6345-uart.txt          |   6 +
>  arch/mips/Kconfig                                  |   1 +
>  arch/mips/bcm63xx/clk.c                            | 181 ++++++++++++++++-----
>  arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +
>  arch/mips/boot/dts/brcm/bcm6328.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +
>  arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   5 +-
>  drivers/tty/serial/bcm63xx_uart.c                  |   6 +-
>  11 files changed, 168 insertions(+), 43 deletions(-)
> 

-- 
Florian
