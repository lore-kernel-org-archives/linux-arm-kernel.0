From: lho@apm.com (Loc Ho)
Date: Tue, 11 Aug 2015 14:47:53 -0600
Subject: [PATCH v3 0/4] edac: Add L3/SoC support to the APM X-Gene SoC EDAC
 driver
Message-ID: <1439326077-25507-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
* Add an function to retrieve the EDAC debugfs node
* Move all debugfs node under EDAC code debugfs node
* Update L3 to check for v1 errata
* Rename error label for L3/SoC add routines
* Re-structure SoC EDAC functions for code readability
* Inline the function xgene_edac_soc_mem_data
* Remove un-necessary { }

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
Loc Ho (4):
  edac: Add an function to retrieve the EDAC debugfs node
  Documentation: Update the APM X-Gene SoC EDAC DTS binding for L3/SoC
    subnodes
  edac: Add L3/SoC EDAC support to the APM X-Gene SoC EDAC driver
  arm64: Add L3/SoC DT subnodes to the APM X-Gene SoC EDAC node

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   23 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   10 +
 drivers/edac/edac_core.h                           |    1 +
 drivers/edac/edac_mc_sysfs.c                       |   10 +
 drivers/edac/xgene_edac.c                          |  827 +++++++++++++++++++-
 5 files changed, 859 insertions(+), 12 deletions(-)
