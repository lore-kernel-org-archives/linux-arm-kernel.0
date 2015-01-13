From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 13 Jan 2015 16:57:39 +0530
Subject: [PATCH V2 0/3] Add clk support for PDMA, SPI and audio on Exynos7
Message-ID: <1421148462-11755-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PDMA0,PDMA1 gate clock, required clks for 5 SPI channels and 
for clks in audio block.

This patchset is dependent on usb clk support from Vivek in below link.
http://www.spinics.net/lists/linux-samsung-soc/msg39342.html

Changes since V1:
	- Added documentation for source clks of peric1 block.
	- Changed the parent of sclk_i2s1_user,sclk_pcm1_user and sclk_spdif_user
	  from divider clk to gate clk.
	- Removed unused clk IDs

Padmavathi Venna (3):
  clk: samsung: exynos7: add gate clock for DMA block
  clk: samsung: exynos7: add clocks for SPI block
  clk: samsung: exynos7: add clocks for audio block

 .../devicetree/bindings/clock/exynos7-clock.txt    |   14 ++
 drivers/clk/samsung/clk-exynos7.c                  |  220 +++++++++++++++++++-
 include/dt-bindings/clock/exynos7-clk.h            |   43 ++++-
 3 files changed, 271 insertions(+), 6 deletions(-)

-- 
1.7.4.4
