From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 17 Jul 2017 11:13:35 +0200
Subject: [PATCH v3 0/5] Add SoM1 support
In-Reply-To: <1499330129-29319-1-git-send-email-claudiu.beznea@microchip.com>
References: <1499330129-29319-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170717091335.adgoomh6yirzdzeh@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2017 at 11:35:24 +0300, Claudiu Beznea wrote:
> Hi all,
> 
> This series adds support for sama5d2 SoM1 devices.
> 
> The at91-sama5d27_som1.dtsi add specific bindings for SoM1 board.
> The at91-sama5d27_som1_ek.dts add specific bindings for SoM1 EK board.
> 
> Thank you,
> Claudiu
> 
> Changes in v3:
> - remove qspi flash mapping for the moment
> - remove at24 and i2c bindings; this will be introduced when
> "Add at24 functionality to read form different EEPROM offsets" patch will
> be accepted
> - change the title of patch 5 from this series from
> "ARM: dts: sama5d27_som1_ek: Add sama5d27 SoM1 EK support" to
> "ARM: dts: at91: at91-sama5d27_som1_ek: Add sama5d27 SoM1 EK support" to
> match the desired prefix
> 
> Changes in v2:
> o in at91-sama5d27_som1.dtsi:
> - increase bootloader and kernel size in flash map (with bootloader
> flash offset the dtb and kernel flash offsets were changed)
> - use right pin for ethernet-phy interrupt
> 
> o in at91-sama5d27_som1_ek.dts:
> - removed memory tag and rely on bootloader to fill the right value
> - use pin macros (from arch/arm/boot/dts/sama5d2-pinfunc.h) wherever
> posible instead of pin numbers
> - remove pinctrl_sensor_power and pinctrl_sensor_reset pin muxing
> since they are not of intereset for this board
> - use "pb4" label for user button instead of "bp1"
> 
> Claudiu Beznea (2):
>   ARM: dts: at91: at91-sama5d27_som1: add sama5d27 SoM1 support
>   ARM: dts: sama5d27_som1_ek: Add sama5d27 SoM1 EK support
> 
> Cristian Birsan (1):
>   drivers: soc: atmel: Add basic support for new sama5d2 SiPs
> 
> Cyrille Pitchen (1):
>   ARM: dts: at91: sama5d2: add QSPI nodes
> 
> Songjun Wu (1):
>   ARM: dts: at91: sama5d2: add isc node
> 
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 178 +++++++++
>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 551 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/sama5d2.dtsi              |  38 ++
>  drivers/soc/atmel/soc.c                     |   8 +
>  drivers/soc/atmel/soc.h                     |   4 +
>  6 files changed, 780 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi
>  create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> 

All applied, thanks!


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
