From: fkan@apm.com (Feng Kan)
Date: Tue,  7 Jan 2014 14:50:35 -0800
Subject: [PATCH V2 0/6] Enable X-Gene platform reboot driver.
Message-ID: <1389135041-16062-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable X-Gene platform driver for the X-Gene platform. Remove the
use of the mask attribute from the reboot dts node. Add support
for using the ACPI and DTS resource for the reboot driver.

V2 Change:
	- Add support for using ACPI resource.

Feng Kan (6):
  Documentation: add dts binding for X-Gene reboot dts node.
  arm64: add missing dts entry for X-Gene platform.
  arm64: Enable system reset via arch Kconfig for X-Gene system.
  power: reset: removed use of the dts mask and use fixed value for
    reset.
  power: reset: change xgene reboot driver to use both acpi and dts    
    resource for reboot.
  acpi: platform: add ACPI code for X-Gene reboot platform driver.

 .../devicetree/bindings/arm64/xgene/reboot.txt     |   10 +++++
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |    5 +++
 drivers/acpi/acpi_platform.c                       |    3 ++
 drivers/power/reset/xgene-reboot.c                 |   38 +++++++++++++++----
 5 files changed, 49 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm64/xgene/reboot.txt

-- 
1.7.6.1
