From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun, 10 Jul 2016 11:24:01 +0200
Subject: No subject
Message-ID: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject: [PATCH v2 0/4] pwm: Add Amlogic Meson SoC PWM Controller

Add support for the PWM controller found in Amlogic Meson SoCs.
This controller provides a dual PWM output with 4 selectable clock source
and a two level divider to achieve a better PWM range.

Currently Meson8b and GXBB SoCs are supported.

Changes since v1 at http://lkml.kernel.org/r/1466173784-15625-1-git-send-email-narmstrong at baylibre.com :
- fix meson8b dtsi

Neil Armstrong (4):
  pwm: Add support for Meson PWM Controller
  dt-bindings: pwm: Add bindings for Meson PWM Controller
  ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller nodes
  ARM: dts: meson8b: Add Meson8b PWM Controller nodes

 .../devicetree/bindings/pwm/pwm-meson.txt          |  21 +
 arch/arm/boot/dts/meson8b.dtsi                     |  21 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  28 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-meson.c                            | 491 +++++++++++++++++++++
 6 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
 create mode 100644 drivers/pwm/pwm-meson.c

-- 
2.7.0
