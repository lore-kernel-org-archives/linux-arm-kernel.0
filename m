From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Oct 2013 18:14:43 +0300
Subject: [PATCH v2 0/7] Tegra124 clock support
Message-ID: <1381850098-12357-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces support for the Tegra124 CAR clocks.                                                                                                    
Based on '[PATCH v3 00/12] Introduce common infra for tegra clocks'                                                                                            

changes since v1:

+ suspend/resume for LP1 (Joseph Lo)
+ fixed some comments
+ account for changes to the common infra code

Joseph Lo (2):
  clk: tegra124: add wait_for_reset and disable_clock for
    tegra_cpu_car_ops
  clk: tegra124: add suspend/resume function for tegra_cpu_car_ops

Peter De Schrijver (5):
  clk: tegra: Add support for PLLSS
  clk: tegra: Add periph regs bank X
  clk: tegra124: Add common clk IDs to clk-id.h
  clk: tegra124: Add new peripheral clocks
  clk: tegra124: Add support for Tegra124 clocks

 drivers/clk/tegra/Makefile               |    1 +
 drivers/clk/tegra/clk-id.h               |   20 +
 drivers/clk/tegra/clk-pll.c              |  172 ++++
 drivers/clk/tegra/clk-tegra-periph.c     |   55 ++
 drivers/clk/tegra/clk-tegra124.c         | 1430 ++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.c                  |   10 +
 drivers/clk/tegra/clk.h                  |    5 +
 include/dt-bindings/clock/tegra124-car.h |  341 +++++++
 8 files changed, 2034 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-tegra124.c
 create mode 100644 include/dt-bindings/clock/tegra124-car.h

-- 
1.7.7.rc0.72.g4b5ea.dirty
