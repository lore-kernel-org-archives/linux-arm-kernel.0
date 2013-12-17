From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 17 Dec 2013 17:26:36 +0800
Subject: [PATCH 0/4] ARM: tegra: re-enable EMC scaling function for Tegra20
Message-ID: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EMC scaling function was lost after Tegra deprecated the legacy
clock driver and switched to CCF driver. In this series, we add the EMC
clock driver in the Tegra CCF driver. And re-register the EMC driver to
the EMC clock driver to support EMC scaling again.

Verified on Seaboard.

Joseph Lo (4):
  ARM: tegra: moving tegra_bct_strapping to tegra-soc.h for global
    visibility
  clk: tegra: add EMC clock driver
  memory: tegra20-emc: move out Tegra20 EMC driver from mach-tegra
  clk: tegra20: enable EMC clock driver

 arch/arm/mach-tegra/Makefile                       |   1 -
 arch/arm/mach-tegra/fuse.h                         |   2 -
 arch/arm/mach-tegra/tegra20_speedo.c               |   1 +
 arch/arm/mach-tegra/tegra2_emc.h                   |  24 ---
 drivers/clk/tegra/Makefile                         |   1 +
 drivers/clk/tegra/clk-emc.c                        | 183 +++++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c                    |  25 +--
 drivers/clk/tegra/clk.h                            |  19 +++
 drivers/memory/Kconfig                             |  10 ++
 drivers/memory/Makefile                            |   1 +
 .../tegra2_emc.c => drivers/memory/tegra20-emc.c   |  16 +-
 include/linux/platform_data/tegra_emc.h            |   7 +
 include/linux/tegra-soc.h                          |   2 +
 13 files changed, 250 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/tegra2_emc.h
 create mode 100644 drivers/clk/tegra/clk-emc.c
 rename arch/arm/mach-tegra/tegra2_emc.c => drivers/memory/tegra20-emc.c (95%)

-- 
1.8.5
