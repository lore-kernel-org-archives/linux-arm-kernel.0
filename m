From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Sep 2018 22:59:39 +0200
Subject: [GIT PULL 2/5] soc/tegra: Changes for v4.20-rc1
In-Reply-To: <20180927205942.30878-1-thierry.reding@gmail.com>
References: <20180927205942.30878-1-thierry.reding@gmail.com>
Message-ID: <20180927205942.30878-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.20-soc

for you to fetch changes up to 4a37f11c8f57ffd6f7397eaf372109d67edd3769:

  soc/tegra: pmc: Implement pad configuration via pinctrl (2018-08-27 12:25:18 +0200)

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Changes for v4.20-rc1

This contains a pinctrl implementation for the pad configuration that
can be controlled from the PMC.

----------------------------------------------------------------
Aapo Vienamo (7):
      dt-bindings: Add Tegra PMC pad configuration bindings
      soc/tegra: pmc: Fix pad voltage configuration for Tegra186
      soc/tegra: pmc: Factor out DPD register bit calculation
      soc/tegra: pmc: Implement tegra_io_pad_is_powered()
      soc/tegra: pmc: Use X macro to generate IO pad tables
      soc/tegra: pmc: Remove public pad voltage APIs
      soc/tegra: pmc: Implement pad configuration via pinctrl

Johan Hovold (1):
      soc/tegra: pmc: Fix child-node lookup

Thierry Reding (1):
      Merge branch 'for-4.20/dt-bindings' into for-4.20/soc

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 ++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++
 drivers/soc/tegra/pmc.c                            | 513 +++++++++++++++------
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
 include/soc/tegra/pmc.h                            |  20 +-
 5 files changed, 599 insertions(+), 148 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
