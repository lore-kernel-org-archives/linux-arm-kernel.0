From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Dec 2011 11:47:04 +0000
Subject: [PATCH v3 0/2] Refactor common Kconfigs for easier maintenance
Message-ID: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common Kconfig options which depend on a long list of board- and
SoC- specific Kconfigs can be cumbersome to maintain, leading to
annoying merge conflicts (although rather trivial ones).

This series factors out the dependencies of CACHE_L2X0 and SMP so
that the knowledge about when these can be enabled is moved to the
relevant board/SoC Kconfig files instead.  New HAVE_L2X0_L2CC and
HAVE_SMP options are defined to mediate the dependencies.

Note that there was no previous post of this whole series.  One of
the patches was posted previously (hence v3).

Dave Martin (2):
  ARM: pl2x0/pl310: Refactor Kconfig to be more maintainable
  ARM: SMP: Refactor Kconfig to be more maintainable

 arch/arm/Kconfig               |   23 +++++++++++++++++++----
 arch/arm/mach-exynos/Kconfig   |    2 ++
 arch/arm/mach-imx/Kconfig      |    3 ++-
 arch/arm/mach-msm/Kconfig      |    1 +
 arch/arm/mach-omap2/Kconfig    |    2 ++
 arch/arm/mach-realview/Kconfig |    9 +++++++++
 arch/arm/mach-vexpress/Kconfig |    2 ++
 arch/arm/mm/Kconfig            |   12 +++++++-----
 arch/arm/plat-mxc/Kconfig      |    1 +
 9 files changed, 45 insertions(+), 10 deletions(-)

--
1.7.4.1
