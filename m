From: sebastian.reichel@collabora.com (Sebastian Reichel)
Date: Thu, 25 Oct 2018 15:30:17 +0200
Subject: [PATCH v5 00/11] AXP8x3 AC and battery power supply support
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Message-ID: <20181025133017.2rdnbgmvdlx67kcz@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Patches 1, 2 & 9 look good to me and do not seem to have any
dependencies. I plan to merge them after the merge window
for 4.20 closes.

-- Sebastian

On Tue, Oct 23, 2018 at 09:53:19PM +0300, Oskari Lemmela wrote:
> AXP813 AC power supply support with input current and
> voltage limiting support.
> 
> AXP803 AC and battery power supply support.
> 
> Changes in v5:
> * Return correct input current limit for values 0x6 and 0x7
> * Add specific compatibles for AXP803
> * Change commit messages
> * Add Vasily Khoruzhick Pinebook DTS patch
> 
> Changes in v4:
> * Change order of axp20x-gpio in axp20x.c
> * Fix indentation and spaces to tabs in axp20x.c
> 
> Changes in v3:
> * Reorder ac_power_supply DT node
> * Rename axp20x_ac_power_set_property function
> * Split mfd commit 
> 
> Changes in v2:
> * Reuse axp813 compatibles for axp803
> * Refactor axp20x_ac_power.c
> 
> Oskari Lemmela (10):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   dt-bindings: power: supply: axp20x: add AXP803 power bindings
>   dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
>   dt-bindings: iio: adc: add AXP803 ADC bindings
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
> 
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: pinebook: enable power supplies
> 
>  .../devicetree/bindings/gpio/gpio-axp209.txt  |  2 +
>  .../bindings/iio/adc/axp20x_adc.txt           |  2 +
>  .../bindings/power/supply/axp20x_ac_power.txt |  4 +
>  .../bindings/power/supply/axp20x_battery.txt  |  1 +
>  arch/arm/boot/dts/axp81x.dtsi                 |  5 +
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 33 +++++++
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  8 ++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
>  drivers/mfd/axp20x.c                          | 20 ++++
>  drivers/power/supply/axp20x_ac_power.c        | 94 +++++++++++++++++++
>  include/linux/mfd/axp20x.h                    |  1 +
>  11 files changed, 178 insertions(+)
> 
> -- 
> 2.17.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181025/638fcd69/attachment.sig>
