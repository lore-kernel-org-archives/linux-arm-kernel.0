From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:10 +0200
Subject: [PATCH 18/34] pinctrl: mvebu: armada-{370,375}: normalize audio pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-19-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit aligns the naming of the audio 'lrclk' pin accross Marvell
SoCs.

Since only the subname is changed, the DT backward compatibility is
not affected.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt          | 2 +-
 .../devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt          | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                              | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c                              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index 24a7450..cc0be9d 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -88,7 +88,7 @@ mpp58         58       gpio, dev(cs0), uart1(rts), tdm(int), audio(extclk),
 mpp59         59       gpo, dev(ale0), uart1(rts), uart0(rts), audio(bclk)
 mpp60         60       gpio, dev(ale1), uart1(rxd), sata0(prsnt), pcie(rstout),
                        audio(sdi)
-mpp61         61       gpo, dev(we1), uart1(txd), audio(rclk)
+mpp61         61       gpo, dev(we1), uart1(txd), audio(lrclk)
 mpp62         62       gpio, dev(a2), uart1(cts), tdm(drx), pcie(clkreq0),
                        audio(mclk), uart0(cts)
 mpp63         63       gpo, spi0(sck), tclk
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
index f942a00..06e5bb0 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -19,7 +19,7 @@ mpp2          2        gpio, dev(ad4), ptp(evreq), led(c0), audio(sdi)
 mpp3          3        gpio, dev(ad5), ptp(trig), led(p3), audio(mclk)
 mpp4          4        gpio, dev(ad6), spi0(miso), spi1(miso)
 mpp5          5        gpio, dev(ad7), spi0(cs2), spi1(cs2)
-mpp6          6        gpio, dev(ad0), led(p1), audio(rclk)
+mpp6          6        gpio, dev(ad0), led(p1), audio(lrclk)
 mpp7          7        gpio, dev(ad1), ptp(clk), led(p2), audio(extclk)
 mpp8          8        gpio, dev (bootcs), spi0(cs0), spi1(cs0)
 mpp9          9        gpio, spi0(sck), spi1(sck), nand(we)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index e295636..5337468 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -354,7 +354,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x0, "gpo", NULL),
 	   MPP_FUNCTION(0x1, "dev", "we1"),
 	   MPP_FUNCTION(0x2, "uart1", "txd"),
-	   MPP_FUNCTION(0x5, "audio", "rclk")),
+	   MPP_FUNCTION(0x5, "audio", "lrclk")),
 	MPP_MODE(62,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
 	   MPP_FUNCTION(0x1, "dev", "a2"),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index 4d3e235..54e9fbd 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -81,7 +81,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x1, "dev", "ad0"),
 		 MPP_FUNCTION(0x3, "led", "p1"),
-		 MPP_FUNCTION(0x4, "audio", "rclk"),
+		 MPP_FUNCTION(0x4, "audio", "lrclk"),
 		 MPP_FUNCTION(0x5, "nand", "io0")),
 	MPP_MODE(7,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-- 
2.1.0
