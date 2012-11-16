From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 16 Nov 2012 17:38:22 +0530
Subject: [PATCH v2 0/4] pm: Add power off control
Message-ID: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PM power_off control to rtc driver, along with this PMIC status
is set to STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC
module.

System power off sequence:-
* Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
* Enable PMIC_POWER_EN in rtc module
* Set rtc ALARM2 time
* Enable ALARM2 interrupt

These patches were tested on AM335x-Bone.

Changes from v1:
	- Incorporated Vaibhav's comments on v1
	  * Changed the time rollover logic with the help of
	    rtc-lib APIs

AnilKumar Ch (2):
  ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
  ARM: dts: AM33XX: Enable system power off control in am335x-bone

Colin Foe-Parker (2):
  mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
  rtc: OMAP: Add system pm_power_off to rtc driver

 .../devicetree/bindings/regulator/tps65217.txt     |    4 +
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
 arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
 drivers/mfd/tps65217.c                             |   12 +++
 drivers/rtc/rtc-omap.c                             |   81 +++++++++++++++++++-
 5 files changed, 107 insertions(+), 1 deletion(-)

-- 
1.7.9.5
