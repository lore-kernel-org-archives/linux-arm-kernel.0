From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Oct 2012 16:57:02 -0700
Subject: [GIT PULL 7/12] ARM: soc: soc-specific updates, take 2
In-Reply-To: <1349135827-24790-1-git-send-email-olof@lixom.net>
References: <1349135827-24790-1-git-send-email-olof@lixom.net>
Message-ID: <1349135827-24790-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch converts the MXS Freescale platform to use irqdomains and
sparse IRQ, in preparation for DT probing and multiplatform kernels.

Conflicts: none.

----------------------------------------------------------------

The following changes since commit 5d3a0a95868a9669816da193bb284121df9031c8:

  Merge branch 'next/cleanup2' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/soc2

for you to fetch changes up to 36246a820075b65907112891b77ff7915fdb06a5:

  Merge tag 'mxs-sparse-irq' of git://git.linaro.org/people/shawnguo/linux-2.6 into next/soc2

----------------------------------------------------------------

Olof Johansson (1):
      Merge tag 'mxs-sparse-irq' of git://git.linaro.org/people/shawnguo/linux-2.6 into next/soc2

Shawn Guo (6):
      gpio/mxs: adopt irq_domain support for mxs gpio driver
      ARM: mxs: retrieve timer irq from device tree
      ARM: mxs: select MULTI_IRQ_HANDLER
      ARM: mxs: adopt irq_domain support for icoll driver
      ARM: mxs: select SPARSE_IRQ
      ARM: mxs: remove mach/irqs.h


 arch/arm/Kconfig                             |  2 +
 arch/arm/boot/dts/imx23.dtsi                 |  5 +-
 arch/arm/boot/dts/imx28.dtsi                 |  5 +-
 arch/arm/mach-mxs/icoll.c                    | 63 +++++++++++++++++++----
 arch/arm/mach-mxs/include/mach/common.h      |  3 +-
 arch/arm/mach-mxs/include/mach/entry-macro.S | 35 -------------
 arch/arm/mach-mxs/include/mach/irqs.h        | 32 ------------
 arch/arm/mach-mxs/mach-mxs.c                 | 39 ++------------
 arch/arm/mach-mxs/timer.c                    | 13 ++++-
 drivers/clk/mxs/clk-imx23.c                  |  2 +-
 drivers/clk/mxs/clk-imx28.c                  |  2 +-
 drivers/gpio/gpio-mxs.c                      | 48 ++++++++++-------
 12 files changed, 112 insertions(+), 137 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-mxs/include/mach/irqs.h
