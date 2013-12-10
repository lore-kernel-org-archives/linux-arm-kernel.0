From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 15:35:15 -0800
Subject: [PATCH 0/8] Modernize pm8921 with irqdomains + regmap
Message-ID: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches lay the groundwork for converting the pm8921 code to 
devicetree as well as simplify the API by migrating the core code
to use the regmap API instead of the custom pm8xxx read/write wrapper.

Please note, I put the generic regmap change in this set of patches.
Hopefully Mark and Samuel/Lee can sort out how these patches should
merge.

Srinivas Ramana (1):
  regmap: Add support for using regmap over ssbi

Stephen Boyd (7):
  mfd: ssbi: Remove platform data structs and hide ssbi type enum
  mfd: ssbi: Constify buffer in ssbi_write
  mfd: ssbi: Mark match table const
  mfd: Move pm8xxx-irq.c contents into only driver that uses it
  mfd: pm8921: Update for genirq changes
  mfd: pm8921: Migrate to irqdomains
  mfd: pm8921: Use ssbi regmap

 drivers/base/regmap/Kconfig       |   5 +-
 drivers/base/regmap/Makefile      |   1 +
 drivers/base/regmap/regmap-ssbi.c | 103 ++++++++++
 drivers/mfd/Kconfig               |  12 +-
 drivers/mfd/pm8921-core.c         | 416 +++++++++++++++++++++++++++++++++-----
 drivers/mfd/pm8xxx-irq.c          | 371 ---------------------------------
 drivers/mfd/ssbi.c                |  16 +-
 include/linux/mfd/pm8xxx/irq.h    |  59 ------
 include/linux/mfd/pm8xxx/pm8921.h |  30 ---
 include/linux/regmap.h            |   4 +
 include/linux/ssbi.h              |  19 +-
 11 files changed, 486 insertions(+), 550 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-ssbi.c
 delete mode 100644 drivers/mfd/pm8xxx-irq.c
 delete mode 100644 include/linux/mfd/pm8xxx/irq.h
 delete mode 100644 include/linux/mfd/pm8xxx/pm8921.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
