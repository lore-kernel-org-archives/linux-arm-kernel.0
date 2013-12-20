From: rapatel@apm.com (Ravi Patel)
Date: Thu, 19 Dec 2013 18:44:59 -0800
Subject: [PATCH 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
Message-ID: <1387507503-7565-1-git-send-email-rapatel@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for APM X-Gene SoC Queue Manager/Traffic Manager.
 QMTM is required by APM X-Gene SoC Ethernet, PktDMA and Security Engine
 subsystems. All subsystems communicate with QMTM using messages which
 include information about the work to be performed and the location of
 associated data buffers.

Ravi Patel (4):
  Documentation: Add documentation for APM X-Gene SoC Queue
    Manager/Traffic Manager DTS binding
  misc: xgene: Add base driver for APM X-Gene SoC Queue Manager/Traffic
    Manager
  arm64: boot: dts: Add DTS entries for APM X-Gene SoC Queue
    Manager/Traffic Manager
  misc: xgene: Add error handling for APM X-Gene SoC Queue
    Manager/Traffic Manager

 .../devicetree/bindings/misc/apm-xgene-qmtm.txt    |   52 ++
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   17 +
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/xgene/Kconfig                         |    1 +
 drivers/misc/xgene/Makefile                        |    5 +
 drivers/misc/xgene/qmtm/Kconfig                    |    8 +
 drivers/misc/xgene/qmtm/Makefile                   |    7 +
 drivers/misc/xgene/qmtm/xgene_qmtm_error.c         |  287 ++++++++
 drivers/misc/xgene/qmtm/xgene_qmtm_main.c          |  768 ++++++++++++++++++++
 drivers/misc/xgene/qmtm/xgene_qmtm_main.h          |  143 ++++
 drivers/misc/xgene/qmtm/xgene_qmtm_storm.c         |  375 ++++++++++
 drivers/misc/xgene/qmtm/xgene_qmtm_storm.h         |  144 ++++
 include/misc/xgene/xgene_qmtm.h                    |  282 +++++++
 15 files changed, 2098 insertions(+)
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

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
