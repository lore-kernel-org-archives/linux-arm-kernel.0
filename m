From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 22 Oct 2015 11:18:35 +0200
Subject: [PATCH 0/4] arm: omap2+: complete dm816x hwmod and clkdev
Message-ID: <5628A9EB.9010005@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to fix support for the dm816x platform, add missing bits in
the 81xx hwmod data.

The clk related patch adds the missing clkdev entries to fix all source
selection in the dmtimer driver.

The last patch adds hwmod support of the spinbox module.

Neil Armstrong (4):
  arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod data
  clk: ti816x: Add missing dmtimer clkdev entries
  arm: plat-omap: add DT support for ti,dm816-timer
  arm: omap2+: Add hwmod spinbox support for dm816x

 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 38 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/dmtimer.c               |  4 ++++
 drivers/clk/ti/clk-816x.c                  |  2 ++
 3 files changed, 44 insertions(+)

-- 
1.9.1
