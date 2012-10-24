From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2012 15:45:20 +0100
Subject: [PATCH 0/6] ux500 fixes bound for the -rcs
Message-ID: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set contains a bunch of fixes which are bound for the
v3.6 Release Candidates. Each of them provides a fix for something
which went wrong during the merge window. Without them we either
can't build the kernel, have no GPIOs, only have one running CPU
core, see unnecessary WARN()s, or individual devices fail at to be
functional.

 arch/arm/boot/dts/dbx5x0.dtsi     |   17 ++++++-
 arch/arm/mach-ux500/cpu-db8500.c  |    1 +
 arch/arm/mach-ux500/cpu.c         |    1 +
 drivers/mfd/ab8500-core.c         |   36 --------------
 drivers/pinctrl/pinctrl-nomadik.c |   96 ++++++++++++++++++-------------------
 5 files changed, 66 insertions(+), 85 deletions(-)
