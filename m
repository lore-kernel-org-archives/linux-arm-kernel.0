From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 14 May 2014 20:03:10 +0200
Subject: [GIT PULL 3/4] Samsung clock clean-up for v3.16
In-Reply-To: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
References: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
Message-ID: <1400090591-5064-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 773424326b51cc851b6e28ff22447ba5fcc5f429:

  clk: samsung: exynos5420: add more registers to restore list (2014-05-14 19:40:24 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git for_3.16/clk_cleanup

for you to fetch changes up to 3bc0c5a16d65ef2a2edb7326f5b77d6a5bcf08a5:

  drivers: clk: use COMMON_CLK_SAMSUNG for Samsung clock support (2014-05-14 19:41:15 +0200)

----------------------------------------------------------------

Samsung clock clean-up for v3.16.

This pull requests contains minor clean-up related to Samsung clock support,
including:

1) move Kconfig entries of Samsung clock drivers to drivers/clk,

2) compile drivers/clk/samsung conditionally when COMMON_CLK_SAMSUNG is
selected,

3) remove obsolete Kconfig lines after moving s3c24xx to CCF.

----------------------------------------------------------------
Pankaj Dubey (4):
      clk: samsung: add new Kconfig for Samsung common clock option
      ARM: select COMMON_CLK_SAMSUNG for ARCH_EXYNOS and ARCH_S3C64XX
      ARM: S3C24XX: move S3C24XX clock Kconfig options to Samsung clock Kconfig file
      drivers: clk: use COMMON_CLK_SAMSUNG for Samsung clock support

Tomasz Figa (1):
      ARM: S3C24XX: Remove omitted Kconfig selects and conditionals

 .../bindings/clock/samsung,s3c2410-clock.txt       |  2 +-
 arch/arm/Kconfig                                   |  4 +--
 arch/arm/mach-s3c24xx/Kconfig                      | 39 +++-------------------
 drivers/clk/Kconfig                                |  2 ++
 drivers/clk/Makefile                               |  2 +-
 drivers/clk/samsung/Kconfig                        | 26 +++++++++++++++
 6 files changed, 37 insertions(+), 38 deletions(-)
 create mode 100644 drivers/clk/samsung/Kconfig
