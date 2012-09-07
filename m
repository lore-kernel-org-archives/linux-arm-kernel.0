From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:40 +0100
Subject: [PATCH 00/19] First HREF Device Tree enablement patch-set
Message-ID: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on v3.6-rc4

This patch consists of Device Tree related enablement for
ST-Ericsson's development HREF hardware reference board.
Most devices are very similar, if not the same to the
previously enabled Snowball low-cost development board.
These are referenced from the relevant .dtsi file and
merely enabled in the HREF specific Device Tree. There 
are also one or two minor Device Tree related fixes which
were stumbled upon along the way.

 arch/arm/boot/dts/hrefv60plus.dts      |  140 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts         |    1 -
 arch/arm/mach-ux500/board-mop500-sdi.c |    4 +-
 arch/arm/mach-ux500/board-mop500.c     |   12 +--
 arch/arm/mach-ux500/board-mop500.h     |    2 +
 drivers/gpio/gpio-tc3589x.c            |  120 +++++++++++++++++++--------
 drivers/i2c/busses/i2c-nomadik.c       |    4 +
 drivers/mfd/mfd-core.c                 |   10 ++-
 drivers/mfd/tc3589x.c                  |  112 +++++++++++++++++++------
 include/linux/mfd/tc3589x.h            |    1 +
 10 files changed, 327 insertions(+), 79 deletions(-)
