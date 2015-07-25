From: lho@apm.com (Loc Ho)
Date: Sat, 25 Jul 2015 01:07:40 -0600
Subject: [PATCH v2 0/3] edac: Add L3/SoC support to the APM X-Gene SoC EDAC
 driver
Message-ID: <1437808063-17592-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
* Update binding documentation accordingly
* Change all single bit defines to BIT(x)
* Add support for L3 version 1 and 2 HW's
* Change to use debug file system for error injection
* In L3/SoC instance add function, allocate EDAC context after all
  initalization successed
* Support raw or detail info for SoC EDAC error reporting

v1:
* Add L3/SoC support to the APM X-Gene SoC EDAC driver

---
Loc Ho (3):
  Documentation: Update the APM X-Gene SoC EDAC DTS binding for L3/SoC
    subnodes
  edac: Add L3/SoC support to the APM X-Gene SoC EDAC driver
  arm64: Add L3/SoC DT subnodes to the APM X-Gene SoC EDAC node

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   23 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   10 +
 drivers/edac/xgene_edac.c                          |  804 ++++++++++++++++++++
 3 files changed, 837 insertions(+), 0 deletions(-)
