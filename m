From: fkan@apm.com (Feng Kan)
Date: Wed, 25 Jun 2014 16:03:20 -0700
Subject: [PATCH V7 0/6] Add X-Gene platform reboot mechanism
Message-ID: <1403737406-6474-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reboot driver for the X-Gene platform. Add generic syscon reboot
driver.

V7 Change:
	- Seem V3 on, the patches were not making in to the mailinglist.
	- Fix build error produced by other ARCH while including this
	  driver. Set to depend on arm64 ARCH for now.

V6 Change:
	- Add documentation for scu node.

V5 Change:
	- Documentation update, endian and access size.

V4 Change:
	- Remove old X-Gene reboot driver
	- Add generic syscon reboot driver
	- Add DTS and Kconfig for X-Gene reboot using syscon method

V3 Change:
	- Remove the reboot driver's use of acpi resource patch.
	- Change the reboot driver to use syscon to parse out 
	  system clock register. Remove the old method of getting
	  register from the reboot driver directly.
	- Remove documentation since its now simple.

V2 Change:
	- Add support for using ACPI resource.

Feng Kan (5):
  power: reset: Add generic SYSCON register mapped reset
  power: reset: Remove X-Gene reboot driver
  arm64: dts: Add X-Gene reboot driver dts node
  arm64: Select reboot driver for X-Gene platform
  Documentation: power: reset: Add documentation for generic SYSCON
    reboot driver

 .../bindings/power/reset/syscon-reboot.txt         |   23 +++++
 arch/arm64/Kconfig                                 |    2 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   13 +++
 drivers/power/reset/Kconfig                        |    8 +-
 drivers/power/reset/Makefile                       |    2 +-
 drivers/power/reset/syscon-reboot.c                |  100 +++++++++++++++++++
 drivers/power/reset/xgene-reboot.c                 |  103 --------------------
 7 files changed, 143 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
 create mode 100644 drivers/power/reset/syscon-reboot.c
 delete mode 100644 drivers/power/reset/xgene-reboot.c

-- 
1.7.6.1
