From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Aug 2012 17:35:42 +0800
Subject: [GIT PULL] CSR SiRFmarco preparing patches
Message-ID: <CAGsJ_4xY17w96vVs1966KJBC5Tt24qyR=YAPbQWMTFrDRs+xog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please pull the following patches which are making mach-prima2 common
for prima2 and coming new marco SoC.
Note the 3/5 patches depend on 2/5:
ARM: PRIMA2: convert to common clk and finish full clk tree
clk: prima2: move from arch/arm/mach to drivers/clk
which have been in Mike's clk-next, you might see:
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=shortlog;h=refs/heads/clk-next

so i rebase other 3 patches on top of commit
bc0e489eb07f4aa2fb5cb9b7ff1fdf4b6ba3bda5.

i guess Mike will not rebase prima2 clk patches any more, so there
will not be merge conflict.

anyway, if i have let prima2-clk go through arm-soc tree but not clk
tree, things should be better.

Regards,
Barry

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:
  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git marco-prepare

Barry Song (4):
      clk: prima2: move from arch/arm/mach to drivers/clk
      ARM: PRIMA2: use DT_MACHINE_START and convert to generic board
      ARM: PRIMA2: adjust Kconfig to support select SoC features
      ARM: SIRF: make sirf irqchip driver optional since new SoCs will have GIC

Binghua Duan (1):
      ARM: PRIMA2: convert to common clk and finish full clk tree

 arch/arm/Kconfig                            |   12 +-
 arch/arm/configs/prima2_defconfig           |    7 +-
 arch/arm/mach-prima2/Kconfig                |   19 +
 arch/arm/mach-prima2/Makefile               |    5 +-
 arch/arm/mach-prima2/clock.c                |  510 ------------
 arch/arm/mach-prima2/{prima2.c => common.c} |   12 +-
 arch/arm/mach-prima2/irq.c                  |    2 +-
 arch/arm/mach-prima2/timer.c                |    8 +-
 drivers/clk/Makefile                        |    1 +
 drivers/clk/clk-prima2.c                    | 1171 +++++++++++++++++++++++++++
 10 files changed, 1216 insertions(+), 531 deletions(-)
 create mode 100644 arch/arm/mach-prima2/Kconfig
 delete mode 100644 arch/arm/mach-prima2/clock.c
 rename arch/arm/mach-prima2/{prima2.c => common.c} (81%)
 create mode 100644 drivers/clk/clk-prima2.c
