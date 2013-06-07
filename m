From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Jun 2013 17:11:18 +0100
Subject: [PATCH 00/10] regulator: ab8500-ext: Refactorings
Message-ID: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch aims to do the following:

 - Separate the AB8500 External Regulator out from the AB8500 core
   one for added control and reduced complexity
 - Enable the AB8500 External Regulator for Device Tree
 - Ensure EXT3 supplies the AUX regulators with voltage

 arch/arm/boot/dts/dbx5x0.dtsi                 |   28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts                |   14 ++++++++++++++
 arch/arm/mach-ux500/board-mop500-regulators.c |    4 +---
 drivers/mfd/ab8500-core.c                     |   10 ++++++++++
 drivers/regulator/Makefile                    |    2 +-
 drivers/regulator/ab8500-ext.c                |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/regulator/ab8500.c                    |   20 ++++----------------
 include/linux/regulator/ab8500.h              |    4 ----
 8 files changed, 137 insertions(+), 27 deletions(-)
