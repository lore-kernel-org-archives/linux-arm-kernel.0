From: lho@apm.com (Loc Ho)
Date: Fri,  8 Nov 2013 15:30:33 -0700
Subject: [PATCH 0/5] ata: Add APM X-Gene SATA controller support
Message-ID: <1383949838-25106-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene SATA controller support

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
Loc Ho (5):
  ata: Export AHCI library functions required by APM X-Gene SATA driver
  arm64: Add APM X-Gene SATA DTS binding
  ata: Add APM X-Gene SATA driver
  ata: Add APM X-Gene SATA serdes functions
  Documentation: Add documentation for APM X-Gene SATA binding

 .../devicetree/bindings/ata/apm-xgene.txt          |   84 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   73 +
 drivers/ata/Kconfig                                |    7 +
 drivers/ata/Makefile                               |    2 +
 drivers/ata/ahci.h                                 |    6 +
 drivers/ata/libahci.c                              |   13 +-
 drivers/ata/sata_xgene.c                           | 1385 ++++++++++++++
 drivers/ata/sata_xgene.h                           |  112 ++
 drivers/ata/sata_xgene_serdes.c                    | 1982 ++++++++++++++++++++
 9 files changed, 3659 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/apm-xgene.txt
 create mode 100644 drivers/ata/sata_xgene.c
 create mode 100644 drivers/ata/sata_xgene.h
 create mode 100644 drivers/ata/sata_xgene_serdes.c
