From: rapatel@apm.com (Ravi Patel)
Date: Fri, 14 Feb 2014 18:21:58 -0800
Subject: [PATCH V3 0/4] mailbox: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
Message-ID: <1392430922-24643-1-git-send-email-rapatel@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for APM X-Gene SoC Queue Manager/Traffic Manager.
 QMTM is required by APM X-Gene SoC Ethernet, PktDMA (XOR Engine) and
 Security Engine subsystems. All subsystems communicate with QMTM using
 messages which include information about the work to be performed and
 the location of associated data buffers.

V3:
 * Switch to mailbox framework
 * Add support for little and big endian kernel
 * Change virt_to_phys function call to dma_zalloc_coherent

V2:
 * Adding COMPILE_TEST dependency for QMTM in Kconfig
 * Updated license banner as per review comments
 * Fixed alignment for macros
 * Changed EXPORT_SYMBOL to EXPORT_SYMBOL_GPL

V1:
 * inital version

Signed-off-by: Ravi Patel <rapatel@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
Ravi Patel (4):
  Documentation: mailbox: APM X-Gene SoC QMTM
  Documentation: devicetree: bindings for APM X-Gene SoC QMTM
  mailbox: xgene: base driver for APM X-Gene SoC QMTM
  arm64: boot: dts: entries for APM X-Gene SoC QMTM

 .../devicetree/bindings/mailbox/apm-xgene-qmtm.txt |   53 ++
 Documentation/mailbox/apm-xgene-qmtm.txt           |  149 ++++++
 MAINTAINERS                                        |    9 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   18 +-
 drivers/mailbox/Kconfig                            |    2 +
 drivers/mailbox/Makefile                           |    1 +
 drivers/mailbox/xgene/Kconfig                      |    9 +
 drivers/mailbox/xgene/Makefile                     |    7 +
 drivers/mailbox/xgene/xgene_qmtm_main.c            |  516 ++++++++++++++++++++
 drivers/mailbox/xgene/xgene_qmtm_main.h            |  112 +++++
 drivers/mailbox/xgene/xgene_qmtm_storm.c           |  358 ++++++++++++++
 include/linux/platform_data/xgene_qmtm.h           |  300 ++++++++++++
 12 files changed, 1533 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apm-xgene-qmtm.txt
 create mode 100644 Documentation/mailbox/apm-xgene-qmtm.txt
 create mode 100644 drivers/mailbox/xgene/Kconfig
 create mode 100644 drivers/mailbox/xgene/Makefile
 create mode 100644 drivers/mailbox/xgene/xgene_qmtm_main.c
 create mode 100644 drivers/mailbox/xgene/xgene_qmtm_main.h
 create mode 100644 drivers/mailbox/xgene/xgene_qmtm_storm.c
 create mode 100644 include/linux/platform_data/xgene_qmtm.h

-- 
1.7.9.5
