From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Sat, 28 Sep 2013 18:25:27 +0200
Subject: [PATCH 0/3] Samsung: DT: Add Device tree for S5PC110/S5PV210 Boards
Message-ID: <1380385530-28522-1-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add initial device tree support for mach s5pv210. It provides 
dts for all old board files and add support for new board: 
Tiny210 from FriendlyARM
This patch series was tested on goni, aquila and tiny210.

Missing features:
 - i2s
 - audio
 - cpufreq
 - camera noon010pc30
 - lcd support(still waiting for Common Display Framework) 
 - touchscreen atmel_mxt_ts
Need to be tested:
 - i2c require touchscreen
 - fimd require lcd
 - fimc require camera
 - mfc require CMA
 - spi 

Mateusz Krawczuk (3):
  ARM: s5pv210: Add board file for boot using Device Tree
  ARM: Samsung: DT: Add Device tree for s5pv210
  ARM: Samsung: DT: Add Device tree for S5PC110/S5PV210 Boards

 arch/arm/boot/dts/Makefile              |   6 +
 arch/arm/boot/dts/s5pv210-aquila.dts    | 407 ++++++++++++++++
 arch/arm/boot/dts/s5pv210-goni.dts      | 486 +++++++++++++++++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi  | 820 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-smdkc110.dts  | 165 +++++++
 arch/arm/boot/dts/s5pv210-smdkv210.dts  | 273 +++++++++++
 arch/arm/boot/dts/s5pv210-tiny210.dts   | 262 ++++++++++
 arch/arm/boot/dts/s5pv210-torbreck.dts  | 157 ++++++
 arch/arm/boot/dts/s5pv210.dtsi          | 498 +++++++++++++++++++
 arch/arm/mach-s5pv210/Kconfig           |  14 +
 arch/arm/mach-s5pv210/Makefile          |   2 +-
 arch/arm/mach-s5pv210/mach-s5pv210-dt.c |  92 ++++
 12 files changed, 3181 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/s5pv210-aquila.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-goni.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-smdkc110.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-smdkv210.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-tiny210.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-torbreck.dts
 create mode 100644 arch/arm/boot/dts/s5pv210.dtsi
 create mode 100644 arch/arm/mach-s5pv210/mach-s5pv210-dt.c

-- 
1.8.1.2
