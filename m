From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 16 Aug 2013 13:19:34 +0530
Subject: [PATCH V2 0/4] clk: Samsung: audss: Add support for Exynos5420
Message-ID: <1376639378-20707-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for audio subsystem clks on Exynos5420. Exynos5420
audio subsystem has a gate bit for ADMA controller and the some of the parent
clks for mout_i2s and sclk_pcm are different from Exynos5250. So this patch
adds provision for supporting both the platforms by determining the parent clk
names based on compatible string.

Changes since V1:
	- parent clocks are determined by using the compatible string and not
	  passed via device tree as done in V1 because the probing order of
	  the clock providers can't be guaranteed.

Andrew Bresticker (3):
  clk: exynos-audss: add support for Exynos 5420
  clk: exynos-audss: set correct parent clocks
  ARM: dts: exynos5420: add audio clock controller

Padmavathi Venna (1):
  ARM: dts: Correct the /include entry on exynos5420 dtsi file

 .../devicetree/bindings/clock/clk-exynos-audss.txt |    7 +++++--
 arch/arm/boot/dts/exynos5420.dtsi                  |   11 ++++++++++-
 drivers/clk/samsung/clk-exynos-audss.c             |   20 +++++++++++++++++++-
 include/dt-bindings/clk/exynos-audss-clk.h         |    3 ++-
 4 files changed, 36 insertions(+), 5 deletions(-)

-- 
1.7.4.4
