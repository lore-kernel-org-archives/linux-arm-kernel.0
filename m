From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 20 Mar 2017 09:43:48 +0100
Subject: [RFT PATCH 0/1] Meson GXBB: use pwm-leds on supported devices
In-Reply-To: <20170318143728.16535-1-martin.blumenstingl@googlemail.com>
References: <20170318143728.16535-1-martin.blumenstingl@googlemail.com>
Message-ID: <a5b18444-6158-7bc2-cb19-0b5a44ea9316@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2017 03:37 PM, Martin Blumenstingl wrote:
> This patch enables brightness support through the pwm-leds driver for
> the GXBB devices which use GPIOAO_13 for their system/status LED.
> 
> Affected devices are:
> - NEXBOX A95X (GXBB, S905 variant)
> - Odroid-C2
> - the Tronsmart Vega S95 series (Meta, Pro, Telos)
> - WeTek Hub
> - WeTek Play 2
> 
> unfortunately my GXBB board (a Tronsmart Vega S95 Meta clone) is not
> working anymore, so I can't test this at all.
> if it works on one of the devices then we can probably assume that it
> works fine on all other devices as well.
> 
> 
> Martin Blumenstingl (1):
>   ARM64: dts: meson-gxbb: convert devices to use pwm-leds
> 
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 18 +++++++++++----
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 16 ++++++++++---
>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 17 ++++++++++----
>  .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      | 19 +++++++++++----
>  .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 27 ++++++++++++++++------
>  5 files changed, 74 insertions(+), 23 deletions(-)
> 

Hi Martin,

I'm concerned about how the LED is managed by the firmware.
The system led is usually managed by the firmware and color is changed
when in suspend or poweroff mode.
But I'm not sure of the behavior if the pin mode is set to PWM.

Can you check this ?

Thanks,
Neil
