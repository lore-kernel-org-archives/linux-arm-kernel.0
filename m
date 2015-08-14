From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Aug 2015 16:48:32 +0200
Subject: [GIT PULL 1/9] clk: tegra: Changes for v4.3-rc1
In-Reply-To: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1439563720-13189-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-clk

for you to fetch changes up to 79cf95c763a11d4b365cd5a627fd1ab4dca67890:

  clk: tegra: Add the DFLL as a possible parent of the cclk_g clock (2015-07-16 10:40:20 +0200)

Thanks,
Thierry

----------------------------------------------------------------
clk: tegra: Changes for v4.3-rc1

This contains the DFLL driver needed to implement CPU frequency scaling
on Tegra.

----------------------------------------------------------------
Mikko Perttunen (1):
      clk: tegra: Introduce ability for SoC-specific reset control callbacks

Paul Walmsley (1):
      clk: tegra: Add DFLL DVCO reset control for Tegra124

Tuomas Tynkkynen (7):
      clk: tegra: Add binding for the Tegra124 DFLL clocksource
      clk: tegra: Add library for the DFLL clock source (open-loop mode)
      clk: tegra: Add closed loop support for the DFLL
      clk: tegra: Add functions for parsing CVB tables
      clk: tegra: Add Tegra124 DFLL clocksource platform driver
      clk: tegra: Save/restore CCLKG_BURST_POLICY on suspend
      clk: tegra: Add the DFLL as a possible parent of the cclk_g clock

 .../bindings/clock/nvidia,tegra124-dfll.txt        |   79 +
 arch/arm/mach-tegra/Kconfig                        |    1 +
 drivers/clk/tegra/Makefile                         |    3 +
 drivers/clk/tegra/clk-dfll.c                       | 1755 ++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h                       |   54 +
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  166 ++
 drivers/clk/tegra/clk-tegra124.c                   |   82 +
 drivers/clk/tegra/clk.c                            |   39 +-
 drivers/clk/tegra/clk.h                            |    3 +
 drivers/clk/tegra/cvb.c                            |  140 ++
 drivers/clk/tegra/cvb.h                            |   67 +
 include/dt-bindings/reset/tegra124-car.h           |   12 +
 13 files changed, 2396 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h
 create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
 create mode 100644 drivers/clk/tegra/cvb.c
 create mode 100644 drivers/clk/tegra/cvb.h
 create mode 100644 include/dt-bindings/reset/tegra124-car.h
