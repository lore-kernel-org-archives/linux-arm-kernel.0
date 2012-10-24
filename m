From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 24 Oct 2012 14:13:39 +0200
Subject: [PATCH 0/2] clk: ux500: Make mtu driver use apb_pclock
Message-ID: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The apb clock was before the "common" clock driver for ux500 was merged,
handled internally by the clock driver. Now this clock needs to be managed
from the mtu driver as a separate clock.

This patches is based in 3.7 rc2.

It is important the "ARM nomadik patch" is merged together with the
clock patch to not break boot. Therefore I suggest this series to go
through Mike Turquettes clock tree.

Ulf Hansson (2):
  clk: ux500: Register mtu apb_pclocks
  ARM: plat-nomadik: Use apb_pclock in mtu driver

 arch/arm/plat-nomadik/timer.c |    8 +++++++-
 drivers/clk/ux500/u8500_clk.c |    9 +++------
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
1.7.10
