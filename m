From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 14:42:36 -0700
Subject: [GIT PULL 5/8] ARM: tegra: SCU base rework
In-Reply-To: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359582159-28816-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra currently relies on the SCU to determine the number of CPU
cores, and also hard-codes the SCU physical address.

This series adds a /cpus node to the Tegra device tree, and updates
the code to rely solely on that to determine the CPU count. A new
API is introduced to query for the existence of SCU registers, and the
SCU register address. Tegra and OMAP2 are converted to use these new
APIs.

This pull request is based on a merge of v3.8-rc3, and arm-soc's
depends/rmk-perf branch.

----------------------------------------------------------------

The following changes since commit 5681f76576af872ced97e8c58ccab3c84a6627e6:

  Merge remote-tracking branch 'korg_arm-soc/depends/rmk-perf' into for-3.9/scu-base-rework

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-scu-base-rework

for you to fetch changes up to 80d9375617f7544f7475e7f07003a08930559d43:

  ARM: OMAP: Make use of available scu_a9_get_base() interface

----------------------------------------------------------------

Hiroshi Doyu (5):
      ARM: tegra: Add CPU nodes to Tegra20 device tree
      ARM: tegra: Add CPU nodes to Tegra30 device tree
      ARM: tegra: Use DT /cpu node to detect number of CPU core
      ARM: Add API to detect SCU base address from CP15
      ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9

Santosh Shilimkar (1):
      ARM: OMAP: Make use of available scu_a9_get_base() interface

 arch/arm/boot/dts/tegra20.dtsi |   17 +++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi |   29 +++++++++++++++++++++++++++++
 arch/arm/include/asm/smp_scu.h |   17 +++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c |    2 +-
 arch/arm/mach-omap2/omap44xx.h |    1 -
 arch/arm/mach-tegra/platsmp.c  |   20 ++------------------
 6 files changed, 66 insertions(+), 20 deletions(-)
