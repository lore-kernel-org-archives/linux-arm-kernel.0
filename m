From: collinsd@codeaurora.org (David Collins)
Date: Wed, 30 Mar 2011 15:16:01 -0700
Subject: [PATCH 0/2] regulator: msm: Add PM8921 regulator driver
Message-ID: <1301523361-5982-1-git-send-email-collinsd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a new regulator driver to control the regulators in
Qualcomm PM8921 PMIC chips.  It also introduces board file changes to use
this new driver with the Qualcomm MSM 8960 platform.

This patch set depends upon the following outstanding PM8XXX and PM8921
patches:

https://patchwork.kernel.org/patch/643231/
https://patchwork.kernel.org/patch/643221/
https://patchwork.kernel.org/patch/643201/
https://patchwork.kernel.org/patch/643211/
https://patchwork.kernel.org/patch/643241/

David Collins (2):
  regulator: pm8921-regulator: Add regulator driver for PM8921
  msm: board-8960: Add support for pm8921-regulator

 arch/arm/mach-msm/Makefile                  |    1 +
 arch/arm/mach-msm/board-msm8960-regulator.c |  303 ++++
 arch/arm/mach-msm/board-msm8960.c           |    6 +
 arch/arm/mach-msm/board-msm8960.h           |   23 +
 drivers/mfd/pm8921-core.c                   |   32 +-
 drivers/regulator/Kconfig                   |   10 +
 drivers/regulator/Makefile                  |    1 +
 drivers/regulator/pm8921-regulator.c        | 2211 +++++++++++++++++++++++++++
 include/linux/mfd/pm8xxx/pm8921.h           |    3 +
 include/linux/regulator/pm8921-regulator.h  |   97 ++
 10 files changed, 2686 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-msm8960-regulator.c
 create mode 100644 arch/arm/mach-msm/board-msm8960.h
 create mode 100644 drivers/regulator/pm8921-regulator.c
 create mode 100644 include/linux/regulator/pm8921-regulator.h

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
