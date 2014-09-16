From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Sep 2014 12:47:59 +0800
Subject: [GIT PULL 2/3] ARM: imx: SoC updates for 3.18
Message-ID: <20140916044758.GB25583@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc folks,

This is the i.MX SoC changes for 3.18.  It's based on imx-cleanup-3.18
pull request for dependency reason.

Please pull, thanks.

Shawn

The following changes since commit 64d14a31d5410ea34641c41795e0ba222bda740c:

  ARM: imx: Remove mach-mxt_td60 board file (2014-09-10 11:17:44 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.18

for you to fetch changes up to 64546e9fe3a5b8cf62c946521c71d0532d399850:

  ARM: imx_v6_v7_defconfig updates (2014-09-16 10:09:43 +0800)

----------------------------------------------------------------
The i.MX SoC updates for 3.18:
 - Add initial devicetree support for i.MX1
 - Support GPT per clock source from OSC for i.MX6
 - A couple of parent selection corrections for i.MX6SL clock driver
 - Support more chip revision for i.MX6
 - Convert pr_warning to pr_warn
 - Add exclusive gate clock support
 - Add BYPASS support for i.MX6 PLL clocks
 - Update i.MX6 clock tree for audio use case
 - A couple of VF610 clock driver updates

----------------------------------------------------------------
Alexander Shiyan (1):
      ARM: i.MX1: Add devicetree support

Anson Huang (3):
      ARM: imx: add cpufreq support for i.mx6sx
      ARM: imx: add gpt_3m clk for i.mx6qdl
      ARM: imx: source gpt per clk from OSC for system timer

Fabio Estevam (4):
      ARM: clk-imx6sl: Remove csi_lcdif_sels[]
      ARM: clk-imx6sl: Select appropriate parents for LCDIF clocks
      ARM: imx_v4_v5_defconfig: Select CONFIG_IMX_WEIM
      ARM: imx_v6_v7_defconfig updates

Fancy Fang (1):
      ARM: clk-imx6sl: correct the pxp and epdc axi clock selections

Jason Liu (1):
      ARM: i.MX6: add more chip revision support

Joe Perches (1):
      arm: mach-imx: Convert pr_warning to pr_warn

Shawn Guo (6):
      ARM: imx: add an exclusive gate clock type
      ARM: imx6q: add BYPASS support for PLL clocks
      ARM: imx6sl: add BYPASS support for PLL clocks
      ARM: imx6sx: add BYPASS support for PLL clocks
      ARM: imx: remove ENABLE and BYPASS bits from clk-pllv3 driver
      ARM: imx: fix register offset of pll7_usb_host gate clock

Shengjiu Wang (4):
      ARM: clk-imx6q: refine clock tree for ESAI
      ARM: clk-imx6q: refine clock tree for ASRC
      ARM: clk-imx6q: refine clock tree for SSI
      ARM: clk-imx6sl: refine clock tree for SSI

Stefan Agner (2):
      ARM: imx: clk-vf610: introduce clks_init_on
      ARM: imx: clk-vf610: Add USBPHY clocks

 arch/arm/configs/imx_v4_v5_defconfig      |  11 +---
 arch/arm/configs/imx_v6_v7_defconfig      |  10 ++-
 arch/arm/mach-imx/Kconfig                 |   8 +++
 arch/arm/mach-imx/Makefile                |   4 +-
 arch/arm/mach-imx/anatop.c                |  13 ++++
 arch/arm/mach-imx/clk-gate-exclusive.c    |  94 +++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c             |  99 +++++++++++++++++++++++-----
 arch/arm/mach-imx/clk-imx6sl.c            | 103 +++++++++++++++++++++++++-----
 arch/arm/mach-imx/clk-imx6sx.c            |  63 +++++++++++++++---
 arch/arm/mach-imx/clk-pllv3.c             |  37 -----------
 arch/arm/mach-imx/clk-vf610.c             |  21 +++++-
 arch/arm/mach-imx/clk.h                   |   3 +
 arch/arm/mach-imx/imx1-dt.c               |  26 ++++++++
 arch/arm/mach-imx/mach-armadillo5x0.c     |   2 +-
 arch/arm/mach-imx/mach-imx6sx.c           |   3 +
 arch/arm/mach-imx/mach-mx31_3ds.c         |   4 +-
 arch/arm/mach-imx/mach-mx31lite.c         |   2 +-
 arch/arm/mach-imx/mach-pcm037.c           |   4 +-
 arch/arm/mach-imx/mxc.h                   |   2 +
 arch/arm/mach-imx/time.c                  |  31 +++++++--
 include/dt-bindings/clock/imx6qdl-clock.h |  35 +++++++++-
 include/dt-bindings/clock/imx6sl-clock.h  |  30 ++++++++-
 include/dt-bindings/clock/imx6sx-clock.h  |  25 +++++++-
 include/dt-bindings/clock/vf610-clock.h   |   5 +-
 24 files changed, 520 insertions(+), 115 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-gate-exclusive.c
 create mode 100644 arch/arm/mach-imx/imx1-dt.c
