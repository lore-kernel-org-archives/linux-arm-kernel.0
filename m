From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Nov 2014 13:48:01 -0800
Subject: [GIT PULL] ARM: SoC fixes for 3.18-rc3
Message-ID: <20141102214801.GA19097@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes

for you to fetch changes up to 4257412db57900e43716d0b7ddd4f4a51e6ed2f4:

  Merge tag 'fixes-against-v3.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2014-11-02 13:37:07 -0800)

----------------------------------------------------------------

ARM: SoC fixes for 3.8-rc3

A surprisingly small batch of fixes for -rc3. Suspiciously small, I'd say.

Anyway, most of this are a few defconfig updates. Some for omap to deal
with kernel binary size (moving ipv6 to module, etc). A larger one for
socfpga that refreshes with some churn, but also turns on a few options
that makes the newly-added board in my bootfarm usable for testing.

OMAP3 will also now warn when booted with legacy (non-DT) boot protocols,
hopefully encouraging those who still care about some of those platforms
to submit DT support and report bugs where needed. Nothing stops working
though, this is just to warn for future deprecation.

Beyond this, very few actual bugfixes. A PXA fix for DEBUG_LL boot hangs,
a missing terminting entry in a dt_match array on RealView a MTD fix on
OMAP with NAND.

----------------------------------------------------------------
Axel Lin (1):
      soc: versatile: Add terminating entry for realview_soc_of_match

Dinh Nguyen (1):
      ARM: socfpga_defconfig: Update defconfig for SoCFPGA

Lad, Prabhakar (1):
      MAINTAINERS: drop list entry for davinci

Olof Johansson (3):
      Merge tag 'fixes-for-v3.18-rc2' of https://github.com/rjarzmik/linux into fixes
      Merge tag 'socfpga_defconfig_for_v3.19' of git://git.rocketboards.org/linux-socfpga-next into fixes
      Merge tag 'fixes-against-v3.18-rc2' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Robert Jarzmik (1):
      ARM: pxa: fix hang on startup with DEBUG_LL

Soren Brinkmann (1):
      MAINTAINERS: Add Soren as reviewer for Zynq

Srinivas Kandagatla (1):
      ARM: multi_v7_defconfig: fix support for APQ8084

Stefan Hengelein (1):
      ARM: ixp4xx: remove compilation warnings in io.h

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Fix bloat caused by having ipv6 built-in
      ARM: omap2plus_defconfig: Fix errors with NAND BCH
      ARM: OMAP2+: Warn about deprecated legacy booting mode

 MAINTAINERS                               |    3 +-
 arch/arm/Kconfig.debug                    |    2 +-
 arch/arm/configs/multi_v7_defconfig       |    2 +
 arch/arm/configs/omap2plus_defconfig      |    4 +-
 arch/arm/configs/socfpga_defconfig        |   71 ++++++++++++-----------------
 arch/arm/mach-ixp4xx/include/mach/io.h    |    4 +-
 arch/arm/mach-omap2/omap_device.c         |    4 ++
 arch/arm/mach-pxa/include/mach/addr-map.h |    5 ++
 drivers/soc/versatile/soc-realview.c      |    1 +
 9 files changed, 46 insertions(+), 50 deletions(-)
