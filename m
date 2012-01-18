From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 17 Jan 2012 22:48:06 -0600
Subject: [RFC PATCH v3] ARM: imx: Add basic imx6q thermal management
Message-ID: <1326862087-17816-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on v3.2 plus recently submitted cpu_cooling functionality here:

http://www.spinics.net/lists/linux-pm/msg26500.html

link to v2 submission:

http://www.spinics.net/lists/arm-kernel/msg155790.html

Changes since v2:
1. Fixed the various issues pointed out in v2
2. Made other code cleanup and a bit of re-organizing
3. Removed unecessary platform driver and device.

Performed some basic testing to ensure proper cooling operating.  If
you want to test this, full testing requires imx6q cpufreq
implementation (not yet in v3.2) and requires an imx6q part that has
temperature sensor calibration fuses correctly burned.

Robert Lee (1):
  ARM: imx: Add basic imx6q thermal management

 arch/arm/boot/dts/imx6q.dtsi    |    1 +
 drivers/thermal/Kconfig         |    6 +
 drivers/thermal/Makefile        |    1 +
 drivers/thermal/imx6q_thermal.c |  520 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 528 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/imx6q_thermal.c
