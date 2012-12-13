From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Dec 2012 13:22:02 +0000
Subject: [PATCH 1/8] Functionality add and bug-fixes related to MMCI regulators
Message-ID: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main purpose of this patch-set is to move the MMCI's secondary
(platform specific) regulator implementation out of platform code
and into use the regulator frame-work. A few bugs were encountered
along the way, so we've fixed those too and bundled them in for
completeness.

 arch/arm/boot/dts/dbx5x0.dtsi                 |    5 ++-
 arch/arm/boot/dts/href.dtsi                   |    1 +
 arch/arm/boot/dts/hrefprev60.dts              |    2 +-
 arch/arm/mach-ux500/board-mop500-regulators.c |   14 +++++++
 arch/arm/mach-ux500/board-mop500-regulators.h |    1 +
 arch/arm/mach-ux500/board-mop500-sdi.c        |   52 -------------------------
 arch/arm/mach-ux500/board-mop500.c            |   44 +++++++++++++++++++++
 drivers/mmc/host/mmci.c                       |   22 +++++++++++
 drivers/mmc/host/mmci.h                       |    1 +
 9 files changed, 88 insertions(+), 54 deletions(-)
