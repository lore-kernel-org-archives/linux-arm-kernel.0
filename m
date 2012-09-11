From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 15:54:57 +0800
Subject: [GIT PULL 2/4] mxs sparse-irq support
In-Reply-To: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347350100-4674-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-sparse-irq

for you to fetch changes up to 6608f13fabdb1f9ecbd502763ba33ca2646834c8:

  ARM: mxs: remove mach/irqs.h (2012-09-03 09:32:17 +0800)

----------------------------------------------------------------
mxs-sparse-irq

The series adds irqdomain support for mach-mxs and then enables
sparse-irq.  It dependes on pull request mxs-dt-3.7.

----------------------------------------------------------------
Shawn Guo (6):
      gpio/mxs: adopt irq_domain support for mxs gpio driver
      ARM: mxs: retrieve timer irq from device tree
      ARM: mxs: select MULTI_IRQ_HANDLER
      ARM: mxs: adopt irq_domain support for icoll driver
      ARM: mxs: select SPARSE_IRQ
      ARM: mxs: remove mach/irqs.h

 arch/arm/Kconfig                             |    2 [32m+[m
 arch/arm/boot/dts/imx23.dtsi                 |    5 [32m+[m[31m-[m
 arch/arm/boot/dts/imx28.dtsi                 |    5 [32m+[m[31m-[m
 arch/arm/mach-mxs/icoll.c                    |   63 [32m++++++++++++++++++++++[m[31m----[m
 arch/arm/mach-mxs/include/mach/common.h      |    3 [32m+[m[31m-[m
 arch/arm/mach-mxs/include/mach/entry-macro.S |   35 [31m--------------[m
 arch/arm/mach-mxs/include/mach/irqs.h        |   32 [31m-------------[m
 arch/arm/mach-mxs/mach-mxs.c                 |   39 [32m++[m[31m--------------[m
 arch/arm/mach-mxs/timer.c                    |   13 [32m+++++[m[31m-[m
 drivers/clk/mxs/clk-imx23.c                  |    2 [32m+[m[31m-[m
 drivers/clk/mxs/clk-imx28.c                  |    2 [32m+[m[31m-[m
 drivers/gpio/gpio-mxs.c                      |   48 [32m++++++++++++[m[31m--------[m
 12 files changed, 112 insertions(+), 137 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-mxs/include/mach/irqs.h
