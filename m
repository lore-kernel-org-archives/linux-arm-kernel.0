From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 29 Sep 2014 22:34:10 +0200
Subject: [GIT PULL] Samsung clock changes for v3.18
Message-ID: <1412022850-7842-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a52ae5a755d980e9ff812c6f45a415ba27bfd33b:

  Merge branch 'clk-fixes' into clk-next (2014-09-17 11:47:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git tags/for_3.18/samsung-clk

for you to fetch changes up to fa0111be4ff30150720db3c3e5ee8d7823921639:

  clk: samsung: exynos4: remove duplicate div_core2 divider clock instantiation (2014-09-24 12:41:33 +0200)

----------------------------------------------------------------
Samsung clock patches for v3.18

1) non-critical fixes (without the need to push to stable)

fa0111be4ff3 clk: samsung: exynos4: remove duplicate div_core2 divider clock instantiation
b511593d7165 clk: samsung: exynos4: fix g3d clocks
c14254300131 clk: samsung: exynos4: add missing smmu_g2d clock and update comments
22842d244af3 clk: samsung: exynos5260: fix typo in clock name
e82ba578ccde clk: samsung: exynos3250: fix width field of mout_mmc0/1
59037b92f440 clk: samsung: exynos3250: fix width and shift of div_spi0_isp clock
5ce37f266650 clk: samsung: exynos3250: fix mout_cam_blk parent list

2) Clock driver extensions

07ccf02ba5c3 dt-bindings: clk: samsung: Document the DMC domain of Exynos3250 CMU
d0e73eaf1925 ARM: dts: exynos3250: Add CMU node for DMC domain clocks
e3c3f19bc618 clk: samsung: exynos3250: Register DMC clk provider
4676f0aab9dc clk: samsung: exynos4: add support for MOUT_HDMI and MOUT_MIXER clocks

----------------------------------------------------------------
Chander Kashyap (1):
      clk: samsung: exynos5260: fix typo in clock name

Krzysztof Kozlowski (3):
      clk: samsung: exynos3250: Register DMC clk provider
      ARM: dts: exynos3250: Add CMU node for DMC domain clocks
      dt-bindings: clk: samsung: Document the DMC domain of Exynos3250 CMU

Marek Szyprowski (3):
      clk: samsung: exynos4: add missing smmu_g2d clock and update comments
      clk: samsung: exynos4: add support for MOUT_HDMI and MOUT_MIXER clocks
      clk: samsung: exynos4: fix g3d clocks

Pankaj Dubey (3):
      clk: samsung: exynos3250: fix mout_cam_blk parent list
      clk: samsung: exynos3250: fix width and shift of div_spi0_isp clock
      clk: samsung: exynos3250: fix width field of mout_mmc0/1

Thomas Abraham (1):
      clk: samsung: exynos4: remove duplicate div_core2 divider clock instantiation

 .../devicetree/bindings/clock/exynos3250-clock.txt |  10 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   6 +
 drivers/clk/samsung/clk-exynos3250.c               | 202 ++++++++++++++++++++-
 drivers/clk/samsung/clk-exynos4.c                  |  18 +-
 drivers/clk/samsung/clk-exynos5260.c               |   2 +-
 include/dt-bindings/clock/exynos3250.h             |  27 +++
 include/dt-bindings/clock/exynos4.h                |  12 +-
 7 files changed, 257 insertions(+), 20 deletions(-)
