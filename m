From: lho@apm.com (Loc Ho)
Date: Wed, 23 Sep 2015 17:40:57 -0700
Subject: [PATCH v5 0/4] edac: Add L3/SoC support to the APM X-Gene SoC EDAC
 driver
Message-ID: <1443055261-8613-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v5:
* Drop the EDAC debugfs export and use the wrapper from maintainer
* Clean up debugfs node function to make use of function wrapper
* Clean up function xgene_edac_l3_v1_errata_chk
* Move SoC part into another patch
* Tested with git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git#edac-debugfs
* Make function xgene_edac_l3_create_debugfs_nodes more readable

v4:
* Remove function for EDAC debugfs node and replace with export variable
* Switch the driver to use the exported edac_debugfs variable
* Revert the if statement logic for function as necessary
* Remove un-necessary code in debugfs creation functions

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
  Documentation: Update the APM X-Gene SoC EDAC DTS binding for L3/SoC
    subnodes
  edac: Add L3 EDAC support to the APM X-Gene SoC EDAC driver
  edac: Add SoC EDAC support to the APM X-Gene SoC EDAC driver
  arm64: Add L3/SoC DT subnodes to the APM X-Gene SoC EDAC node

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   23 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   10 +
 drivers/edac/xgene_edac.c                          | 1165 ++++++++++++++++----
 3 files changed, 1004 insertions(+), 194 deletions(-)
