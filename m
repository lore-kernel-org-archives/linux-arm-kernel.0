From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Sep 2012 08:53:14 +0200
Subject: [PATCH] i.MX: remove legacy clock support
Message-ID: <1347346396-27669-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the last leftovers from the i.MX legacy clock support.
As a bonus we get rid of mach/clock.h

----------------------------------------------------------------
Sascha Hauer (2):
      ARM: i.MX clk pllv1: move mxc_decode_pll code to its user
      ARM: i.MX remove last leftovers from legacy clock support

 arch/arm/mach-imx/Makefile             |    2 +-
 arch/arm/mach-imx/clk-pllv1.c          |   49 +++++-
 arch/arm/mach-imx/clk.c                |    3 +
 arch/arm/mach-imx/clk.h                |    3 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c  |    1 -
 arch/arm/plat-mxc/Makefile             |    2 +-
 arch/arm/plat-mxc/clock.c              |  257 --------------------------------
 arch/arm/plat-mxc/cpufreq.c            |    1 -
 arch/arm/plat-mxc/include/mach/clock.h |   70 ---------
 9 files changed, 54 insertions(+), 334 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk.c
 delete mode 100644 arch/arm/plat-mxc/clock.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/clock.h
