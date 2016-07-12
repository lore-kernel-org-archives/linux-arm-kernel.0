From: hotran@apm.com (Hoan Tran)
Date: Mon, 11 Jul 2016 17:30:13 -0700
Subject: [PATCH v2 0/3] hwmon: xgene: Add support for X-Gene hwmon driver
Message-ID: <1468283416-12780-1-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds hardware temperature and power reading support ?for
APM X-Gene SoC using the mailbox communication interface.
For device tree, it is the standard DT mailbox.
For ACPI, it is the PCC mailbox.

For ACPI, tested with this patch[1] which supports PCC subspace 2
[1] http://www.spinics.net/lists/linux-acpi/msg66041.html
 - [PATCH v3] mailbox: pcc: Support HW-Reduced Communication Subspace type 2

v2
 - Increase power reading accurateness by using 2 registers
(a register for Watt, another for milli-Watt)
 - Remove power reading for SoC
 - Fix review comments from Guenter

v1
 - Initial

Hoan Tran (3):
  Documentation: dtb: xgene: Add hwmon dts binding documentation
  hwmon: xgene: Add hwmon driver
  arm64: dts: apm: Add X-Gene SoC hwmon to device tree

 .../devicetree/bindings/hwmon/apm-xgene-hwmon.txt  |  14 +
 Documentation/hwmon/xgene-hwmon                    |  30 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |   5 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   5 +
 drivers/hwmon/Kconfig                              |   7 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/xgene-hwmon.c                        | 772 +++++++++++++++++++++
 7 files changed, 834 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
 create mode 100644 Documentation/hwmon/xgene-hwmon
 create mode 100644 drivers/hwmon/xgene-hwmon.c

-- 
1.9.1
