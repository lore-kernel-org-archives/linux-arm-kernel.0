From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:08 -0700
Subject: [GIT PULL 06/10] ARM: tegra: powergate driver changes
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes all the changes to Tegra's powergate driver for 3.14.
These are separate out, since the Tegra DRM changes for 3.14 rely on the
new APIs introduced here.

A few cleanups and fixes are included, plus additions of Tegra124 SoC
support, and a new API for manipulating Tegra's IO rail deep power down
states.

This branch is based on tag tegra-for-3.14-dmas-resets-rework, in order
to avoid conflicts with the addition of common reset controller support
to the powergate driver.

----------------------------------------------------------------

The following changes since commit 8a0a1af30cbf56b41220a02e34835022c4d72f41:

  spi: tegra: checking for ERR_PTR instead of NULL

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-powergate

for you to fetch changes up to 9d4450ae87398e248e8700e3507748e0d1751e25:

  ARM: tegra: Add IO rail support

----------------------------------------------------------------

Thierry Reding (7):
      ARM: tegra: Fix some whitespace oddities
      ARM: tegra: Rename cpu0 powergate to crail
      ARM: tegra: Export tegra_powergate_power_off()
      ARM: tegra: Export tegra_powergate_remove_clamping()
      ARM: tegra: Add Tegra124 powergate support
      ARM: tegra: Special-case the 3D clamps on Tegra124
      ARM: tegra: Add IO rail support

 arch/arm/mach-tegra/powergate.c | 195 ++++++++++++++++++++++++++++++++++-
 include/linux/tegra-powergate.h |  48 +++++++++
 2 files changed, 240 insertions(+), 3 deletions(-)
