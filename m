From: rapatel@apm.com (Ravi Patel)
Date: Fri, 20 Dec 2013 18:57:27 -0800
Subject: [PATCH V2 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
Message-ID: <1387594651-25771-1-git-send-email-rapatel@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for APM X-Gene SoC Queue Manager/Traffic Manager.
 QMTM is required by APM X-Gene SoC Ethernet, PktDMA (XOR Engine) and
 Security Engine subsystems. All subsystems communicate with QMTM using
 messages which include information about the work to be performed and
 the location of associated data buffers.  

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
  Documentation: Add documentation for APM X-Gene SoC Queue
    Manager/Traffic Manager DTS binding
  misc: xgene: Add base driver for APM X-Gene SoC Queue Manager/Traffic
    Manager
  arm64: boot: dts: Add DTS entries for APM X-Gene SoC Queue
    Manager/Traffic Manager
  misc: xgene: Add error handling for APM X-Gene SoC Queue
    Manager/Traffic Manager

 .../devicetree/bindings/misc/apm-xgene-qmtm.txt    |   51 ++
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   17 +
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/xgene/Kconfig                         |    1 +
 drivers/misc/xgene/Makefile                        |    5 +
 drivers/misc/xgene/qmtm/Kconfig                    |    9 +
 drivers/misc/xgene/qmtm/Makefile                   |    7 +
 drivers/misc/xgene/qmtm/xgene_qmtm_error.c         |  283 ++++++++
 drivers/misc/xgene/qmtm/xgene_qmtm_main.c          |  765 ++++++++++++++++++++
 drivers/misc/xgene/qmtm/xgene_qmtm_main.h          |  138 ++++
 drivers/misc/xgene/qmtm/xgene_qmtm_storm.c         |  370 ++++++++++
 drivers/misc/xgene/qmtm/xgene_qmtm_storm.h         |  139 ++++
 include/misc/xgene/xgene_qmtm.h                    |  277 +++++++
 15 files changed, 2071 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/apm-xgene-qmtm.txt
 create mode 100644 drivers/misc/xgene/Kconfig
 create mode 100644 drivers/misc/xgene/Makefile
 create mode 100644 drivers/misc/xgene/qmtm/Kconfig
 create mode 100644 drivers/misc/xgene/qmtm/Makefile
 create mode 100644 drivers/misc/xgene/qmtm/xgene_qmtm_error.c
 create mode 100644 drivers/misc/xgene/qmtm/xgene_qmtm_main.c
 create mode 100644 drivers/misc/xgene/qmtm/xgene_qmtm_main.h
 create mode 100644 drivers/misc/xgene/qmtm/xgene_qmtm_storm.c
 create mode 100644 drivers/misc/xgene/qmtm/xgene_qmtm_storm.h
 create mode 100644 include/misc/xgene/xgene_qmtm.h

-- 
1.7.9.5
