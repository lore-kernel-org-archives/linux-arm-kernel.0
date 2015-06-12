From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jun 2015 17:31:01 -0700
Subject: [PATCH v2 0/6] SPMI regulator driver
Message-ID: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the regulators found on Qualcomm's
SPMI PMICs. The first patch is the "basic" driver that doesn't have
any non-standard features. The next 4 patches add ways to configure some
of the non-standard features that are generic but aren't supported
in the regulator framework. And the final patch adds support
for the non-standard features and some vendor specific features to
the SPMI regulator driver.

Changes since v1:
 * Split driver into standard and non-standard patches to ease review
 * New patches to regulator framework for non-standard features
 * Added bypass support
 * Namespaced macros
 * Switch to set_load() ops instead of get_optimum_mode()
 * Consolidated range finding code
 * Used delay op to calculate how long to delay after setting voltage on FTSMPS

Stephen Boyd (6):
  regulator: Add QCOM SPMI regulator driver
  regulator: Add system_load constraint
  regulator: Add pull down support
  regulator: Add soft start support
  regulator: Add input current limit support
  regulator: qcom-spmi: Add vendor specific configuration

 .../bindings/regulator/qcom,spmi-regulator.txt     |  183 +++
 .../devicetree/bindings/regulator/regulator.txt    |    5 +
 drivers/regulator/Kconfig                          |   11 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/core.c                           |   27 +
 drivers/regulator/of_regulator.c                   |   12 +
 drivers/regulator/qcom_spmi-regulator.c            | 1678 ++++++++++++++++++++
 include/linux/regulator/driver.h                   |   10 +
 include/linux/regulator/machine.h                  |    8 +
 9 files changed, 1935 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
 create mode 100644 drivers/regulator/qcom_spmi-regulator.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
