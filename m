From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 26 Dec 2013 16:44:20 -0800
Subject: [PATCH 0/7] misc Tegra clock fixes
Message-ID: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes for various clock-related issues found during bringup of
Tegra124-based Venice2 and Norrin boards.

Andrew Bresticker (3):
  clk: tegra: fix sdmmc clks on Tegra1x4
  clk: tegra: cclk_lp has a pllx/2 divider
  clk: tegra: use max divider if divider overflows

David Ung (1):
  clk: tegra: PLLD2 fixes for hdmi

Gabe Black (1):
  clk: tegra: Fix PLLP rate table

Mark Zhang (1):
  clk: tegra: fix host1x clock on Tegra124

Rhyland Klein (1):
  clk: tegra: Fix PLLD mnp table

 drivers/clk/tegra/clk-divider.c          |  2 +-
 drivers/clk/tegra/clk-id.h               |  4 +++
 drivers/clk/tegra/clk-tegra-periph.c     |  4 +++
 drivers/clk/tegra/clk-tegra-super-gen4.c |  2 +-
 drivers/clk/tegra/clk-tegra114.c         |  8 +++---
 drivers/clk/tegra/clk-tegra124.c         | 46 +++++++++++++++++++-------------
 6 files changed, 41 insertions(+), 25 deletions(-)

-- 
1.8.5.1
