From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  5 Apr 2013 11:03:40 -0600
Subject: [GIT PULL 2/8] ARM: tegra: minor fixes
In-Reply-To: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365181426-11547-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a variety of small build and run-time fixes that
weren't important enough for 3.9.

* Enable CPU errata WARs in secondary reset handler as a preparation
  for multi-platform support, and a related fix.
* Don't touch DBLGAR in reset/resume handlers, so enable the code to
  run on A15 cores.
* Minor build fixes.
* A fix to the Tegra clock driver.
* Some error-handling fixes.

This branch is based on the previous fixes-for-mmc pull request.

----------------------------------------------------------------

The following changes since commit 908ab9368866e6edf0edebdd546adefd5f3128f9:

  ARM: dts: tegra: fix the activate polarity of cd-gpio in mmc host

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.10-fixes

for you to fetch changes up to eebd1fda2342014a50ed3fd132e5dc6e8b5251e8:

  ARM: tegra: powergate: Don't error out if new state == old state

----------------------------------------------------------------

Hiroshi Doyu (2):
      ARM: tegra: Fix unchecked return value
      memory: tegra30: Fix build error w/o PM

Joseph Lo (2):
      ARM: tegra: don't unlock MMIO access to DBGLAR
      ARM: tegra: fix the logical detection of power on sequence of warm boot CPUs

Peter De Schrijver (1):
      clk: tegra: No 7.1 super clk dividers on Tegra20

Stephen Warren (3):
      ARM: tegra: add CPU errata WARs to Tegra reset handler
      ARM: tegra: remove save/restore of CPU diag register
      ARM: tegra: fix ignored return value of regulator_enable

Thierry Reding (2):
      ARM: tegra: Export tegra_powergate_sequence_power_up()
      ARM: tegra: powergate: Don't error out if new state == old state

 arch/arm/mach-tegra/board-harmony-pcie.c |    7 +++-
 arch/arm/mach-tegra/cpuidle-tegra30.c    |    4 ---
 arch/arm/mach-tegra/headsmp.S            |    3 --
 arch/arm/mach-tegra/platsmp.c            |    5 ++-
 arch/arm/mach-tegra/pm.c                 |   19 ----------
 arch/arm/mach-tegra/powergate.c          |    4 ++-
 arch/arm/mach-tegra/reset-handler.S      |   48 ++++++++++++++++++++-----
 drivers/clk/tegra/clk-tegra20.c          |   36 ++-----------------
 drivers/memory/tegra30-mc.c              |    2 ++
 9 files changed, 56 insertions(+), 72 deletions(-)
