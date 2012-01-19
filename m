From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 18 Jan 2012 20:27:30 -0600
Subject: [RFC PATCH v4] ARM: imx: Add basic imx6q thermal management
Message-ID: <1326940051-31016-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on v3.2 plus recently submitted cpu_cooling functionality here:

http://www.spinics.net/lists/linux-pm/msg26500.html

link to previous submissions:
v3: http://www.spinics.net/lists/arm-kernel/msg155955.html
v2: http://www.spinics.net/lists/arm-kernel/msg155790.html
v1: http://www.spinics.net/lists/arm-kernel/msg155111.html

Changes in v4:
1.  Removed bad suspend/resume assignment into thermal class.  After further
examination and discussion with SoC designers, a sequence is now used 
for making measurements that is is unaffected by system suspendresumes.  
Temp Sensor automatically powers off in hardware during the low power mode
caused by a system suspend.
2.  Moved some structures from static to dynamic allocation.
3.  Added some noise handling to temperatuer sensor readings.

Changes in v3:
1. Fixed the various issues pointed out in v2
2. Made other code cleanup and a bit of re-organizing
3. Removed unecessary platform driver and device.

Changes in v2:
1. Cleaned up some style issues pointed out in v1
2. Made various other code cleanup and re-organizing
3. Added temperature sensor calibration
4. Created platform driver and device to hook into pm suspend.


Performed some basic testing to ensure proper cooling operating.  If
you want to test this, full testing requires imx6q cpufreq
implementation (not yet in v3.2) and requires an imx6q part that has
temperature sensor calibration fuses correctly burned.

Robert Lee (1):
  ARM: imx: Add basic imx6q thermal management

 arch/arm/boot/dts/imx6q.dtsi    |    1 +
 drivers/thermal/Kconfig         |    6 +
 drivers/thermal/Makefile        |    1 +
 drivers/thermal/imx6q_thermal.c |  540 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 548 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/imx6q_thermal.c
