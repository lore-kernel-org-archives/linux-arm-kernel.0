From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 Oct 2018 11:37:09 +0800
Subject: [PATCH 0/4] AXP8x3 AC and battery power supply support
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Message-ID: <CAGb2v666d=aMi8u51t-=1mskCdLhifEw0iN7BWNxmQGod=F77A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 3:34 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 AC and battery power supply support.
> AXP803/AXP813 AC power supply support with input current and
> voltage limiting support.
>
> Oskari Lemmela (4):
>   dt-bindings: add compatibles for AXP803 AC and battery power supplies
>   ARM: dtsi: axp81x: add AC power supply subnode

The prefix should be "ARM: dts: axp81x: "

>   arm64: allwinner: a64: add battery and AC power supply support

This should be "arm64: dts: allwinner: a64: <board>: add ..."

>   power: supply: add AXP803/AXP813 AC and battery power supply support
>
>  .../devicetree/bindings/gpio/gpio-axp209.txt  |   3 +-
>  .../bindings/iio/adc/axp20x_adc.txt           |   3 +-
>  .../bindings/power/supply/axp20x_ac_power.txt |   4 +
>  .../bindings/power/supply/axp20x_battery.txt  |   1 +
>  arch/arm/boot/dts/axp81x.dtsi                 |   5 +
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     |  31 +++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |   8 +
>  drivers/iio/adc/axp20x_adc.c                  |   1 +
>  drivers/mfd/axp20x.c                          |  22 +-
>  drivers/pinctrl/pinctrl-axp209.c              |   1 +
>  drivers/power/supply/axp20x_ac_power.c        | 194 ++++++++++++++++++
>  drivers/power/supply/axp20x_battery.c         |   3 +
>  include/linux/mfd/axp20x.h                    |   1 +
>  13 files changed, 274 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>
