From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 26 Aug 2014 23:35:11 +0800
Subject: [RFC PATCH 0/2] ARM: imx6: add BYPASS support for PLLs
Message-ID: <1409067313-32063-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC patch series adds BYPASS support for i.MX6 PLLs.  It's
motivated by an ESAI audio use case, where on-board audio codec provides
the master clock to ESAI controller via path anaclk pad -->
PLL_AUDIO --> ESAI.  This is not possible with the current clock driver
implementation, where clock source of PLL is hard-coded to be OSC24M.
The first patch adds an example implementation for i.MX6Q clock driver
to make above clock path become possible.

The second patch is only for showing code removal from clk-pllv3 driver,
and shouldn't be applied until all i.MX6 clock drivers handle BYPASS and
ENABLE on their own, just like i.MX6Q clock driver does in the first
patch.

Shawn Guo (2):
  ARM: imx: add BYPASS support for PLL clocks
  ARM: imx: remove ENABLE and BYPASS bits from clk-pllv3 driver

 arch/arm/mach-imx/clk-imx6q.c             | 57 ++++++++++++++++++++++++++-----
 arch/arm/mach-imx/clk-pllv3.c             | 37 --------------------
 include/dt-bindings/clock/imx6qdl-clock.h | 23 ++++++++++++-
 3 files changed, 71 insertions(+), 46 deletions(-)

-- 
1.9.1
