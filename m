From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 3 Sep 2012 09:55:05 +0200
Subject: [PATCH 0/8] i2c: at91: cleanup and dt support
In-Reply-To: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <50446259.8020504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2012 11:21 AM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Hi,
> 
> This set of patches is based on Nikolaus at91_i2c driver.
> 
> Ludovic Desroches (8):
>   i2c: at91: use managed resources
>   i2c: at91: add warning about transmission issues for some devices
>   i2c: at91: use an id table for SoC dependent parameters
>   ARM: at91: do not configure at91sam9g10 twi pio as open-drain
>   i2c: at91: add dt support to i2c-at91
>   ARM: at91: add clocks for I2C DT entries
>   ARM: dts: add twi nodes for atmel SOCs
>   ARM: dts: add twi nodes for atmel boards

For the whole patch series (with Jean-Christophe remarks about *dts
modifications*):

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


>  .../devicetree/bindings/i2c/atmel-i2c.txt          |  30 +++
>  arch/arm/boot/dts/at91sam9260.dtsi                 |  23 +--
>  arch/arm/boot/dts/at91sam9263.dtsi                 |  23 +--
>  arch/arm/boot/dts/at91sam9263ek.dts                |  20 +-
>  arch/arm/boot/dts/at91sam9g20.dtsi                 |   4 +
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |  28 +--
>  arch/arm/boot/dts/at91sam9g25ek.dts                |  12 ++
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |  33 ++--
>  arch/arm/boot/dts/at91sam9m10g45ek.dts             |   8 +
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |  33 ++--
>  arch/arm/boot/dts/at91sam9n12ek.dts                |   8 +
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |  69 +++----
>  arch/arm/mach-at91/at91rm9200.c                    |   2 +-
>  arch/arm/mach-at91/at91rm9200_devices.c            |  11 +-
>  arch/arm/mach-at91/at91sam9260.c                   |   4 +-
>  arch/arm/mach-at91/at91sam9260_devices.c           |   8 +-
>  arch/arm/mach-at91/at91sam9261.c                   |   3 +-
>  arch/arm/mach-at91/at91sam9261_devices.c           |  31 ++-
>  arch/arm/mach-at91/at91sam9263.c                   |   3 +-
>  arch/arm/mach-at91/at91sam9263_devices.c           |   2 +-
>  arch/arm/mach-at91/at91sam9g45.c                   |   6 +-
>  arch/arm/mach-at91/at91sam9g45_devices.c           |   4 +-
>  arch/arm/mach-at91/at91sam9n12.c                   |   2 +
>  arch/arm/mach-at91/at91sam9rl.c                    |   4 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c            |   2 +-
>  arch/arm/mach-at91/at91sam9x5.c                    |   6 +-
>  drivers/i2c/busses/Kconfig                         |   6 +
>  drivers/i2c/busses/i2c-at91.c                      | 217 +++++++++++++--------
>  28 files changed, 367 insertions(+), 235 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/atmel-i2c.txt
> 


-- 
Nicolas Ferre
