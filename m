From: lho@apm.com (Loc Ho)
Date: Sat,  9 Nov 2013 00:00:26 -0700
Subject: [PATCH v2 0/5] ata: Add APM X-Gene SATA controller support
Message-ID: <1383980431-6572-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ata: Add APM X-Gene SATA controller support

v2:
 * Clean up file sata_xgene.c with Lindent and etc
 * Clean up file sata_xgene_serdes.c with Lindent and etc
 * Add description to each patch

v1:
 * inital version

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
Loc Ho (5):
  ata: Export AHCI library functions required by APM X-Gene SATA driver
  arm64: Add APM X-Gene DTS entry for SATA controllers
  ata: Add APM X-Gene SATA driver
  ata: Add APM X-Gene SATA serdes functions
  Documentation: Add documentation for APM X-Gene SATA DTS binding

 .../devicetree/bindings/ata/apm-xgene.txt          |   84 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   73 +
 drivers/ata/Kconfig                                |    7 +
 drivers/ata/Makefile                               |    2 +
 drivers/ata/ahci.h                                 |    6 +
 drivers/ata/libahci.c                              |   13 +-
 drivers/ata/sata_xgene.c                           | 1394 ++++++++++++++
 drivers/ata/sata_xgene.h                           |  112 ++
 drivers/ata/sata_xgene_serdes.c                    | 2004 ++++++++++++++++++++
 9 files changed, 3690 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/apm-xgene.txt
 create mode 100644 drivers/ata/sata_xgene.c
 create mode 100644 drivers/ata/sata_xgene.h
 create mode 100644 drivers/ata/sata_xgene_serdes.c
