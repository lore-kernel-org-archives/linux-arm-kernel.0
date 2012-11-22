From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Nov 2012 10:59:15 +0100
Subject: [PATCH] i.MX6 clock
Message-ID: <1353578358-23509-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following contains fixes/cleanups for the i.MX6 clock support,
mostly driven by the missing SATA clock support.

----------------------------------------------------------------
Sascha Hauer (3):
      ARM i.MX6: rename PLLs according to datasheet
      ARM i.MX6: Fix ethernet PLL clocks
      ARM i.MX6: remove gate_mask from pllv3

 .../devicetree/bindings/clock/imx6q-clock.txt      |    9 ++-
 arch/arm/mach-imx/clk-imx6q.c                      |   39 ++++++++---
 arch/arm/mach-imx/clk-pllv3.c                      |   72 ++------------------
 arch/arm/mach-imx/clk.h                            |    3 +-
 4 files changed, 40 insertions(+), 83 deletions(-)
