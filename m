From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 14:06:16 -0600
Subject: [GIT PULL 05/10] ARM: tegra: i2c driver enhancements mostly related
 to clocking
In-Reply-To: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347653181-19936-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a number of fixes and cleanups to the Tegra I2C
driver related to clocks. These are based on the common clock conversion
in order to avoid duplicating the clock driver changes before and after
the conversion. Finally, a bug-fix related to I2C_M_NOSTART is included.

This branch is based on previous pull request tegra-for-3.7-common-clk.

----------------------------------------------------------------

The following changes since commit b4350f40f73b75efdceae3d9e04266979acabd8c:

  ARM: Tegra: Add smp_twd clock for Tegra20

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-drivers-i2c

for you to fetch changes up to fd301cc4e5ba839050be135a178031bcd0d363a5:

  i2c: tegra: dynamically control fast clk

----------------------------------------------------------------

Laxman Dewangan (6):
      ARM: tegra: clock: add i2c fast clock entry in clock table
      i2c: tegra: pass proper name for getting clock
      ARM: tegra: clock: add connection name in i2c clock entry
      ARM: tegra: clock: remove unused clock entry for i2c
      i2c: tegra: I2_M_NOSTART functionality not supported in Tegra20
      i2c: tegra: dynamically control fast clk

 arch/arm/mach-tegra/tegra20_clocks_data.c |   20 ++--
 arch/arm/mach-tegra/tegra30_clocks_data.c |   15 ++-
 drivers/i2c/busses/i2c-tegra.c            |  130 +++++++++++++++++-------
 3 files changed, 110 insertions(+), 55 deletions(-)
