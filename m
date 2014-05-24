From: lho@apm.com (Loc Ho)
Date: Fri, 23 May 2014 19:21:03 -0600
Subject: No subject
Message-ID: <1400894467-1585-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC EDAC driver.

v2:
* Add EDAC entry in MAINTAINERS for APM EDAC driver
* Remove the MC scrub patch
* Remove the word 'Caches' from Kconfig
* Change all MASK defines to use BIT(x)
* Update comment or remove them
* Wrap error injection code around CONFIG_EDAC_DEBUG
* Change function name xgene_edac_mc_hw_init to xgene_edac_mc_irq_ctl
* Change all function XXX_hw_init to XXX_hw_ctl
* Fix typo 'activie'
* Move calling function edac_mc_alloc after resource retrieval
* Check for NULL on platform_get_resource return if reference directly
* Add documentation for struct xgene_edac_pmd_ctx
* Move L1 and L2 check out of function xgene_edac_pmd_check to its own
  functions
* Use for loop for configure each CPU of an PMD
* Replace /2 by >> 1
* Remove unnecessary comment on edac_device_add_device failure
* Make mem_err_ip static const
* Unwind EDAC register correctly if failed
---
Loc Ho (4):
  MAINTAINERS: Add entry for APM X-Gene SoC EDAC driver
  Documentation: Add documentation for the APM X-Gene SoC EDAC DTS
    binding
  edac: Add APM X-Gene SoC EDAC driver
  arm64: Add APM X-Gene SoC EDAC DTS entries

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   70 +
 MAINTAINERS                                        |    8 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   89 +
 drivers/edac/Kconfig                               |    9 +-
 drivers/edac/Makefile                              |    3 +
 drivers/edac/xgene_edac.c                          | 1993 ++++++++++++++++++++
 6 files changed, 2171 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
 create mode 100644 drivers/edac/xgene_edac.c
