From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Jan 2015 16:59:59 +0100
Subject: [GIT PULL 3/4] ARM: tegra: Core code changes for v3.20
In-Reply-To: <1422028800-759-1-git-send-email-thierry.reding@gmail.com>
References: <1422028800-759-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1422028800-759-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.20-soc

for you to fetch changes up to 3568df3d31d62b4368830cc6aac868cecdefd187:

  soc: tegra: Add thermal reset (thermtrip) support to PMC (2015-01-23 16:20:49 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Core code changes for v3.20

This contains a couple of preparatory patches for 64-bit support. A new
feature is implemented in the power-management controller which allows
it to switch off the SoC if it overheats.

----------------------------------------------------------------
Mikko Perttunen (3):
      of: Add descriptions of thermtrip properties to Tegra PMC bindings
      ARM: tegra: Add PMC thermtrip programming to Jetson TK1 device tree
      soc: tegra: Add thermal reset (thermtrip) support to PMC

Paul Walmsley (1):
      soc/tegra: pmc: restrict compilation of suspend-related support to ARM

Thierry Reding (5):
      clocksource: Build Tegra timer on 32-bit ARM only
      soc/tegra: Add Tegra132 support
      soc/tegra: fuse: Constify tegra_fuse_info structures
      soc/tegra: fuse: Add Tegra132 support
      soc/tegra: pmc: Add Tegra132 support

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  26 +++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   7 ++
 arch/arm/mach-tegra/Kconfig                        |   4 +
 drivers/clocksource/Kconfig                        |   3 +
 drivers/clocksource/Makefile                       |   2 +-
 drivers/soc/tegra/fuse/fuse-tegra.c                |   1 +
 drivers/soc/tegra/fuse/fuse-tegra30.c              |   9 +-
 drivers/soc/tegra/pmc.c                            | 124 ++++++++++++++++++++-
 include/soc/tegra/fuse.h                           |   1 +
 include/soc/tegra/pm.h                             |   2 +-
 10 files changed, 167 insertions(+), 12 deletions(-)
