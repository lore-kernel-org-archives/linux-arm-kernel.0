From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:13 +0200
Subject: [PATCH 21/34] pinctrl: mvebu: armada-370: align VDD cpu-pd pin naming
 with datasheet
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-22-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with the datasheet, this commit renames the VDD
function of the MPP4 pin.

While this changes the DT compatibility, it is not considered to be a
problem since this pin is unlikely to be used for anything but
debugging purposes.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt          | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index 44aedd5..3a7dc0e 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -17,7 +17,7 @@ mpp0          0        gpio, uart0(rxd)
 mpp1          1        gpo, uart0(txd)
 mpp2          2        gpio, i2c0(sck), uart0(txd)
 mpp3          3        gpio, i2c0(sda), uart0(rxd)
-mpp4          4        gpio, cpu_pd(vdd)
+mpp4          4        gpio, vdd(cpu-pd)
 mpp5          5        gpo, ge0(txclkout), uart1(txd), spi1(clk), audio(mclk)
 mpp6          6        gpio, ge0(txd0), sata0(prsnt), tdm(rst), audio(sdo)
 mpp7          7        gpo, ge0(txd1), tdm(dtx), audio(lrclk)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 1429872..a7adb41 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -52,7 +52,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x2, "uart0", "rxd")),
 	MPP_MODE(4,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
-	   MPP_FUNCTION(0x1, "cpu_pd", "vdd")),
+	   MPP_FUNCTION(0x1, "vdd", "cpu-pd")),
 	MPP_MODE(5,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
 	   MPP_FUNCTION(0x1, "ge0", "txclkout"),
-- 
2.1.0
