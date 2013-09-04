From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 4 Sep 2013 17:20:07 +0300
Subject: [PATCH v2 0/4] Introduce table driven initializations
Message-ID: <1378304438-7780-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a table driven initialization method for the
audio, PMC and gate clocks. It's similar to the table we already have for                                                                                      
the periph clocks.                                                                                                                                             

Changes since v1:

* Use parent names directly in TEGRA_INIT_DATA_GATE()

Peter De Schrijver (4):
  clk: tegra: simplify periph clock data
  clk: tegra: convert Tegra114 gate clocks to table
  clk: tegra114: table driven audio clock init
  clk: tegra114: table driven PMC clock init

 drivers/clk/tegra/clk-tegra114.c |  892 +++++++++++++++-----------------------
 drivers/clk/tegra/clk-tegra20.c  |    4 +-
 drivers/clk/tegra/clk-tegra30.c  |    4 +-
 drivers/clk/tegra/clk.h          |   93 ++++-
 4 files changed, 436 insertions(+), 557 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
