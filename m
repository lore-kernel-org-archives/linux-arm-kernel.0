From: tim.kryger@linaro.org (Tim Kryger)
Date: Tue, 4 Feb 2014 11:51:38 -0800
Subject: [PATCH v2 0/5] Add Broadcom Kona PWM Support
Message-ID: <1391543503-14773-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces the driver for the Kona PWM controller found in
Broadcom mobile SoCs like bcm281xx and updates the device tree and the
defconfig to enable use of this hardware on the bcm28155 AP board.

Changes since v1:
  - Fixed up macros to be clearer and more complete
  - Corrected spelling and punctuation mistakes
  - Added support for polarity
  - Made peripheral clock use more efficient
  - Made prescale and duty computation clearer
  - Moved Makefile addition to keep alphabetical
  - Split complex lines into multiple steps

Tim Kryger (5):
  Documentation: dt: Add Kona PWM binding
  pwm: kona: Introduce Kona PWM controller support
  ARM: dts: Declare the PWM for bcm11351 (bcm281xx)
  ARM: dts: Enable the PWM for bcm28155 AP board
  ARM: bcm_defconfig: Enable PWM and Backlight

 .../devicetree/bindings/pwm/bcm-kona-pwm.txt       |  24 ++
 arch/arm/boot/dts/bcm11351.dtsi                    |   8 +
 arch/arm/boot/dts/bcm28155-ap.dts                  |   4 +
 arch/arm/configs/bcm_defconfig                     |   2 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-bcm-kona.c                         | 291 +++++++++++++++++++++
 7 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
 create mode 100644 drivers/pwm/pwm-bcm-kona.c

-- 
1.8.0.1
