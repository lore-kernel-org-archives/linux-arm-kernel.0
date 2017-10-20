From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Oct 2017 13:56:00 +0200
Subject: [GIT PULL 4/7] thermal: tegra: Changes for v4.15-rc1
In-Reply-To: <20171020115603.9828-1-thierry.reding@gmail.com>
References: <20171020115603.9828-1-thierry.reding@gmail.com>
Message-ID: <20171020115603.9828-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.15-thermal

for you to fetch changes up to 7afebede62bed77ebae34fc64406984949d2a127:

  thermal: Add Tegra BPMP thermal sensor driver (2017-10-19 16:31:47 +0200)

This pulls in parts of both the tegra-for-4.15-dt-bindings and
tegra-for-4.15-firmware tags in order to resolve a build time
dependency.

Thierry

----------------------------------------------------------------
thermal: tegra: Changes for v4.15-rc1

This contains the Tegra186 BPMP thermal driver. It is used to monitor
and access several thermal sensors found in the SoC.

----------------------------------------------------------------
Mikko Perttunen (4):
      dt-bindings: Add bindings for nvidia,tegra186-bpmp-thermal
      firmware: tegra: Expose tegra_bpmp_mrq_return()
      firmware: tegra: Add stubs when BPMP not enabled
      thermal: Add Tegra BPMP thermal sensor driver

Thierry Reding (3):
      dt-bindings: clock: tegra: Add sor1_out clock
      Merge branch 'for-4.15/dt-bindings' into for-4.15/thermal
      Merge branch 'for-4.15/firmware' into for-4.15/thermal

Timo Alho (1):
      firmware: tegra: Propagate error code to caller

 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |  32 +++
 drivers/firmware/tegra/bpmp.c                      |  27 ++-
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/tegra/Kconfig                      |   7 +
 drivers/thermal/tegra/Makefile                     |   3 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c         | 263 +++++++++++++++++++++
 include/dt-bindings/clock/tegra210-car.h           |   1 +
 .../dt-bindings/thermal/tegra186-bpmp-thermal.h    |  14 ++
 include/soc/tegra/bpmp.h                           |  45 +++-
 9 files changed, 381 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
 create mode 100644 drivers/thermal/tegra/tegra-bpmp-thermal.c
 create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h
