From: tushar.b@samsung.com (Tushar Behera)
Date: Wed, 11 Jun 2014 11:02:16 +0530
Subject: [PATCH 0/3] Fix boot-hang on Peach-pit and Enable audio
Message-ID: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With next-20140610, Peach-pit/Peach-pi board hangs during boot if we
run 'sound init' during u-boot. The issue is fixed in following patches.
While at it, also enable audio support for Peach-pi board.

How to test audio on Peach-pi:
* On top of exynos_defconfig, enable SND_SOC_SNOW and PL330_DMA.
* Run 'sound init' at u-boot prompt.

Tushar Behera (3):
  clk: exynos-audss: Keep the parent of mout_audss always enabled
  ARM: dts: Update the parent for Audss clocks in Exynos5420
  ARM: dts: Enable audio support for Peach-pi board

 arch/arm/boot/dts/exynos5420.dtsi         |    2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts |   31 +++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos-audss.c    |   17 +++++++++++++---
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
1.7.9.5
