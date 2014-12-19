From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 19 Dec 2014 18:53:43 +0530
Subject: [PATCH 0/4] Add clk and dt support for PDMA and SPI on Exynos7
Message-ID: <1418995427-7712-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PDMA0,PDMA1 gate clock and required clks for 5 SPI channels.
Also enable the support for PDMA and 5 SPI channels in DT.

This patchset is dependent on usb clk support from Vivek in below link.
http://www.spinics.net/lists/linux-samsung-soc/msg39342.html

Padmavathi Venna (4):
  clk: samsung: exynos7: add gate clock for DMA block
  clk: samsung: exynos7: add clocks for SPI block
  clk: samsung: exynos7: add clocks for audio block
  arm64: dts: Add PDMA and SPI device tree node for exynos7

 .../devicetree/bindings/clock/exynos7-clock.txt    |    6 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  113 ++++++++++
 drivers/clk/samsung/clk-exynos7.c                  |  221 +++++++++++++++++++-
 include/dt-bindings/clock/exynos7-clk.h            |   46 ++++-
 4 files changed, 380 insertions(+), 6 deletions(-)

-- 
1.7.4.4
