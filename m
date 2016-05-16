From: hotran@apm.com (Hoan Tran)
Date: Mon, 16 May 2016 09:17:24 -0700
Subject: [PATCH 0/3] Add support for X-Gene hwmon driver
Message-ID: <1463415447-29903-1-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds hardware temperature and power reading support ?for
APM X-Gene SoC's using the mailbox communication interface.
For device tree, it is the standard DT mailbox.
For ACPI, it is the PCC mailbox.

For ACPI, tested with this patch[1] which supports PCC subspace 2
[1] https://lkml.org/lkml/2016/5/6/482
 - [PATCH v2] mailbox: pcc: Support HW-Reduced Communication Subspace Type 2

Hoan Tran (3):
  Documentation: dtb: xgene: Add hwmon dts binding documentation
  hwmon: xgene: Adds hwmon driver
  arm64: dts: apm: Add X-Gene SoC hwmon to device tree

 .../devicetree/bindings/hwmon/apm-xgene-hwmon.txt  |  14 +
 Documentation/hwmon/xgene-hwmon                    |  32 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |   5 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   5 +
 drivers/hwmon/Kconfig                              |   7 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/xgene-hwmon.c                        | 801 +++++++++++++++++++++
 7 files changed, 865 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
 create mode 100644 Documentation/hwmon/xgene-hwmon
 create mode 100644 drivers/hwmon/xgene-hwmon.c

-- 
1.9.1
