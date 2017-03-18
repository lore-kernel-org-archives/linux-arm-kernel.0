From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 18 Mar 2017 15:37:27 +0100
Subject: [RFT PATCH 0/1] Meson GXBB: use pwm-leds on supported devices
Message-ID: <20170318143728.16535-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables brightness support through the pwm-leds driver for
the GXBB devices which use GPIOAO_13 for their system/status LED.

Affected devices are:
- NEXBOX A95X (GXBB, S905 variant)
- Odroid-C2
- the Tronsmart Vega S95 series (Meta, Pro, Telos)
- WeTek Hub
- WeTek Play 2

unfortunately my GXBB board (a Tronsmart Vega S95 Meta clone) is not
working anymore, so I can't test this at all.
if it works on one of the devices then we can probably assume that it
works fine on all other devices as well.


Martin Blumenstingl (1):
  ARM64: dts: meson-gxbb: convert devices to use pwm-leds

 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 18 +++++++++++----
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 16 ++++++++++---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 17 ++++++++++----
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      | 19 +++++++++++----
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 27 ++++++++++++++++------
 5 files changed, 74 insertions(+), 23 deletions(-)

-- 
2.12.0
