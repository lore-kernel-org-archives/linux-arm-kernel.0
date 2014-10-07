From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Oct 2014 15:36:08 +0100
Subject: [PATCH v2 0/4] watchdog: Introduce new driver to support ST's Watchdog
Message-ID: <1412692572-14031-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

Basic driver to support ST's LPC Watchdog device.

Kind regards,
Lee

v1 => v2:
 - Fixed reset enable masks
 - Fixed DT documentation

Lee Jones (4):
  ARM: STi: DT: STiH407: Add Device Tree node for LPC Watchdog
  ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
  watchdog: st_wdt: Provide binding documentation for ST's LPC Watchdog
    driver
  watchdog: st_wdt: Add new driver for ST's LPC Watchdog

 .../devicetree/bindings/watchdog/st-lpc-wdt.txt    |  30 ++
 arch/arm/boot/dts/stih407.dtsi                     |  10 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/watchdog/Kconfig                           |  16 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/st_wdt.c                          | 325 +++++++++++++++++++++
 6 files changed, 383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt
 create mode 100644 drivers/watchdog/st_wdt.c

-- 
1.9.1
