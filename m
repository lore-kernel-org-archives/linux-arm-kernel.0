From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Fri, 8 Aug 2014 15:02:46 +0800
Subject: [PATCH V3 0/3] refine clock tree for esai in imx6q
Message-ID: <cover.1407481023.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

refine clock tree for esai in imx6q

Changes for V3
- Drop patch3, for waiting bypass mode implementation.
- As Lucas Stach suggestion, add new API for exclusive clock.

Changes for V2
- Add pll5_sel And update the comments for patch 2.
- As the bypass mode is not supported in clk tree, so update the 
- comments for patch 3.


Shengjiu Wang (3):
  ARM: clk-imx6q: refine clock tree for ESAI
  ARM: clk-gate2: Add API imx_clk_gate2_exclusive for clk_gate2
  ARM: clk-imx6q: Add missing lvds and anaclk clock to the clock tree

 arch/arm/mach-imx/clk-gate2.c             |   18 +++++++++++++++++-
 arch/arm/mach-imx/clk-imx6q.c             |   25 ++++++++++++++++++-------
 arch/arm/mach-imx/clk.h                   |    2 ++
 include/dt-bindings/clock/imx6qdl-clock.h |   13 ++++++++++---
 4 files changed, 47 insertions(+), 11 deletions(-)

-- 
1.7.9.5
