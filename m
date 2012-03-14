From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 14:19:58 +0000
Subject: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Message-ID: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set splits out ux500 and ARM specific variants from mmci
core code, applies generic bindings for use by all variants, then 
enables the ux500 variant for use with Device Tree.

 Documentation/devicetree/bindings/mmc/mmci.txt |   27 +++
 arch/arm/boot/dts/db8500.dtsi                  |    6 +-
 arch/arm/boot/dts/snowball.dts                 |   30 +++-
 arch/arm/mach-ux500/board-mop500.c             |    3 +-
 drivers/mmc/host/Makefile                      |    2 +-
 drivers/mmc/host/mmci-arm.c                    |   65 ++++++
 drivers/mmc/host/mmci-ux500.c                  |  260 ++++++++++++++++++++++++
 drivers/mmc/host/mmci.c                        |  194 +++++-------------
 drivers/mmc/host/mmci.h                        |   37 ++++
 9 files changed, 473 insertions(+), 151 deletions(-)
