From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 11:32:38 -0700
Subject: [GIT PULL] ARM: tegra: common clock framework fixes
Message-ID: <1360780358-2866-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of small fixes are included to the new Tegra common clock
driver. These are: Missing locking, definition of device tree clock IDs
not matching the binding, a static cleanup, missing initialization of
some UART clocks.

This branch is based on Tegra's previous pull request tegra-for-3.9-dt.
This dependency is caused by the one patch that edits the device tree.
If this causes a problem, I can drop the final two patches in this pull
request for now, and rebase it onto previous tegra-for-3.9-soc-ccf
instead.

----------------------------------------------------------------

The following changes since commit 3fbf07d80b40f73c304624179381f9038bd03b74:

  ARM: dt: tegra30: Rename "smmu" to "iommu"

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-soc-ccf-fixes

for you to fetch changes up to 527fad1bc519df8eedd397482febb51526e5d987:

  clk: tegra: initialise parent of uart clocks

----------------------------------------------------------------

Joseph Lo (1):
      clk: tegra: fix wrong clock index between se to sata_cold

Laxman Dewangan (1):
      clk: tegra: initialise parent of uart clocks

Peter De Schrijver (3):
      clk: tegra: Implement locking for super clock
      clk: tegra: Add missing spinlock for hclk and pclk
      clk: tegra: local arrays should be static

Stephen Warren (2):
      clk: tegra: fix driver to match DT binding
      ARM: tegra: remove clock-frequency properties from serial nodes

 arch/arm/boot/dts/tegra20.dtsi  |    5 ----
 arch/arm/boot/dts/tegra30.dtsi  |    5 ----
 drivers/clk/tegra/clk-super.c   |   18 ++++++++++---
 drivers/clk/tegra/clk-tegra20.c |   22 ++++++++++------
 drivers/clk/tegra/clk-tegra30.c |   47 +++++++++++++++++++---------------
 5 files changed, 56 insertions(+), 41 deletions(-)
