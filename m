From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:14 +0200
Subject: [PATCH 22/34] pinctrl: mvebu: armada-370: align spi1 clock pin naming
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-23-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Across all SoCs, even on Armada 370 for SPI0, the clock pin uses the
'sck' subname and not 'clk', so this commit adjusts the code and
documentation accordingly.

Since this commit only changes the subname, DT backward compatibility
is not affected.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt          | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index 3a7dc0e..add7c38 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -18,7 +18,7 @@ mpp1          1        gpo, uart0(txd)
 mpp2          2        gpio, i2c0(sck), uart0(txd)
 mpp3          3        gpio, i2c0(sda), uart0(rxd)
 mpp4          4        gpio, vdd(cpu-pd)
-mpp5          5        gpo, ge0(txclkout), uart1(txd), spi1(clk), audio(mclk)
+mpp5          5        gpo, ge0(txclkout), uart1(txd), spi1(sck), audio(mclk)
 mpp6          6        gpio, ge0(txd0), sata0(prsnt), tdm(rst), audio(sdo)
 mpp7          7        gpo, ge0(txd1), tdm(dtx), audio(lrclk)
 mpp8          8        gpio, ge0(txd2), uart0(rts), tdm(drx), audio(bclk)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index a7adb41..73dc1bc 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -57,7 +57,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x0, "gpo", NULL),
 	   MPP_FUNCTION(0x1, "ge0", "txclkout"),
 	   MPP_FUNCTION(0x2, "uart1", "txd"),
-	   MPP_FUNCTION(0x4, "spi1", "clk"),
+	   MPP_FUNCTION(0x4, "spi1", "sck"),
 	   MPP_FUNCTION(0x5, "audio", "mclk")),
 	MPP_MODE(6,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
-- 
2.1.0
