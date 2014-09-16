From: carlo@caione.org (Carlo Caione)
Date: Tue, 16 Sep 2014 22:43:33 +0200
Subject: [PATCH 0/4] ARM: meson: watchdog driver
Message-ID: <1410900217-5162-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the watchdog found on Amlogic MesonX SoCs. The
watchdog is used also to reboot the device.

DTSI and multi_v7_defconfig are updated and proper documentation is added.

No documentation is provided by Amlogic, the code is reverse-engineered by the
code available at http://openlinux.amlogic.com:8000/download/

This patchset depends on:
[1] [PATCH 0/6] ARM: meson: initial support for MesonX SoCs
[2] [PATCH 0/2] ARM: meson: add clocksource support

[1] http://www.spinics.net/lists/arm-kernel/msg362521.html
[2] http://www.spinics.net/lists/arm-kernel/msg362483.html

Carlo Caione (4):
  ARM: docs: add documentation binding for meson watchdog
  ARM: meson: add watchdog driver
  ARM: DTS: meson: update DTSI to add watchdog node
  ARM: defconfig: update multi_v7_defconfig

 .../devicetree/bindings/watchdog/meson-wdt.txt     |  13 ++
 arch/arm/boot/dts/meson.dtsi                       |   5 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/meson_wdt.c                       | 219 +++++++++++++++++++++
 6 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 create mode 100644 drivers/watchdog/meson_wdt.c

-- 
1.9.1
