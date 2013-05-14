From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 May 2013 16:44:32 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.10
Message-ID: <20130514084430.GC16250@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.10

for you to fetch changes up to de78a23d73ba7f1d08f3e1aeaa0a03cb912c62a0:

  ARM: imx: fix typo in gpu3d_shader_sels (2013-05-12 21:39:51 +0800)

----------------------------------------------------------------
The imx fixes for 3.10:

* A few imx6 clock fixes.  Nothing is extremely important, but since
  we're still in early -rc, I send them for 3.10 inclusion.

* Having bootloader handle ARM errata, we will need to replicate the
  diagnostic register of boot cpu into secondary cores, since
  bootloader only sets up boot cpu.  Otherwise, errata workaround simply
  does not work.

----------------------------------------------------------------
Dirk Behme (1):
      ARM i.MX6: correct MLB clock configuration

Philipp Zabel (1):
      ARM i.MX6q: Fix periph_clk2_sel and periph2_clk2_sel clocks

Shawn Guo (2):
      ARM: imx: replicate the diagnostic register of boot cpu into secondary cores
      ARM: imx: fix typo in gpu3d_shader_sels

 arch/arm/mach-imx/clk-imx6q.c |   11 ++++++-----
 arch/arm/mach-imx/headsmp.S   |   12 ++++++++++++
 arch/arm/mach-imx/platsmp.c   |   14 ++++++++++++++
 3 files changed, 32 insertions(+), 5 deletions(-)
