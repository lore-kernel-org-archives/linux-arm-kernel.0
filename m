From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 5 Jul 2017 08:17:21 +0200
Subject: [PATCH v2 0/5] Add SoM1 support
In-Reply-To: <1499086572-6083-1-git-send-email-claudiu.beznea@microchip.com>
References: <1499086572-6083-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170705061721.achgce3jw7fy3aly@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 03, 2017 at 03:56:07PM +0300, Claudiu Beznea wrote:
> Hi all,
> 
> This series adds support for sama5d2 SoM1 devices.
> 
> The at91-sama5d27_som1.dtsi add specific bindings for SoM1 board.
> The at91-sama5d27_som1_ek.dts add specific bindings for SoM1 EK board.
> 
> The sama5d27_som1_ek uses a EEPROM binding, "start-offset", which is
> introduced in patch series: "[RFC PATCH 0/3] Add at24 functionality to
> read form different EEPROM offsets".
> 
> Thank you,
> Claudiu
> 

For the whole set of patches:
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

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
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
