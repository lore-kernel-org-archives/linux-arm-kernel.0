From: fkan@apm.com (Feng Kan)
Date: Tue, 14 Jan 2014 17:07:32 -0800
Subject: [PATCH V3 0/3] Enable X-Gene platform reboot driver.
Message-ID: <1389748055-23534-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable X-Gene platform driver for the X-Gene platform. Change the
driver to use syscon to access the system clock unit's system
reset register.

V2 Change:
	- Add support for using ACPI resource.

V3 Change:
	- Remove the reboot driver's use of acpi resource patch.
	- Change the reboot driver to use syscon to parse out 
	  system clock register. Remove the old method of getting
	  register from the reboot driver directly.
	- Remove documentation since its now simple.

Feng Kan (3):
  arm64: add reboot dts entry for X-Gene platform.
  arm64: Enable system reset via arch Kconfig for X-Gene system.
  power: reset: use syscon driver to parse reboot register from scu

 arch/arm64/Kconfig                 |    2 ++
 arch/arm64/boot/dts/apm-storm.dtsi |   10 ++++++++++
 drivers/power/reset/xgene-reboot.c |   33 +++++++++++++++++----------------
 3 files changed, 29 insertions(+), 16 deletions(-)

-- 
1.7.6.1
