From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 08:55:49 +0000
Subject: [PATCH 00/12] Functionality add and bug-fixes related to MMCI
 regulators
Message-ID: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main purpose of this patch-set is to move the MMCI's secondary
(platform specific) regulator implementation out of platform code
and into use the regulator frame-work. A few bugs were encountered
along the way, so we've fixed those too and bundled them in for
completeness.

 arch/arm/boot/dts/dbx5x0.dtsi          |    7 ++--
 arch/arm/boot/dts/href.dtsi            |    1 +
 arch/arm/boot/dts/hrefprev60.dts       |    2 +-
 arch/arm/mach-ux500/board-mop500-sdi.c |   52 ---------------------------
 arch/arm/mach-ux500/board-mop500.c     |   61 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.c                |   18 ++++++++--
 drivers/mmc/host/mmci.h                |    1 +
 drivers/regulator/gpio-regulator.c     |   17 ++++++---
 8 files changed, 96 insertions(+), 63 deletions(-)
