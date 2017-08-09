From: code@mmayer.net (Markus Mayer)
Date: Wed,  9 Aug 2017 14:56:28 -0700
Subject: [PATCH v3 0/4] thermal: add brcmstb AVS TMON driver
Message-ID: <20170809215632.4124-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

This series adds the brcmstb AVS TMON driver.

The driver was originally written by Brian Norris.

This series is also available at
https://github.com/mmayer/linux/tree/brcmstb-thermal-4.13-v4.

v1 of this series can be found at https://lkml.org/lkml/2017/6/5/921
v2 of this series can be found at https://lkml.org/lkml/2017/7/21/585
v3 of this series can be found at https://lkml.org/lkml/2017/7/31/710

Changes since v3:
- Rebased on v4.13-rc3 to resolve conflicts in the MAINTAINERS file

Changes since v2:
- replaced calls to pr_debug() with calls to dev_dbg() [PATCH 2/4 only]
- all other patches are unchanged from v2

Changes since v1:
- Fixed wording in binding document
- Fixed lincensing to consistently mention GPL v2
- Use thermal_zone_get_slope() and thermal_zone_get_offset()
- Some minor clean-ups

Brian Norris (2):
  Documentation: devicetree: add binding for Broadcom STB AVS TMON
  thermal: add brcmstb AVS TMON driver

Markus Mayer (2):
  ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL
  arm64: defconfig: add CONFIG_BRCMSTB_THERMAL

 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  20 ++
 MAINTAINERS                                        |   8 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/broadcom/Kconfig                   |   7 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/brcmstb_thermal.c         | 386 +++++++++++++++++++++
 8 files changed, 425 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c

-- 
2.7.4
