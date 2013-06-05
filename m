From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 16:51:24 +0300
Subject: [PATCH 0/2] PLL m,n,p init from SoC files
Message-ID: <1370440301-3562-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The m,n,p fields don't have the same bit offset and width across all PLLs.
This patchset allows SoC specific files to indicate the offset and width.
It also provides the data for Tegra114.

Peter De Schrijver (2):
  clk: tegra: allow PLL m,n,p init from SoC files
  clk: tegra: PLL m,n,p init for Tegra114

 drivers/clk/tegra/clk-pll.c      |   60 ++++++++++++++++-------------
 drivers/clk/tegra/clk-tegra114.c |   77 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.h          |   32 ++++++++++------
 3 files changed, 130 insertions(+), 39 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
