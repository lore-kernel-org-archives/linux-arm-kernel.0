From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:21 +0200
Subject: [PATCH 29/34] pinctrl: mvebu: armada-38x: add nand functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-30-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version of the Armada 38x datasheet documents several new
NAND related functions on various MPP pins. This commit adds the
description of these new functions to the Armada 38x pinctrl driver as
well as to its DT binding documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt      | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c                          | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 066e26a..278887d 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -56,9 +56,9 @@ mpp37         37       gpio, ptp(clk), ge1(rxclk), sd0(d3), dev(ad8)
 mpp38         38       gpio, ptp(evreq), ge1(rxd1), ref(clk_out0), sd0(d0), dev(ad4)
 mpp39         39       gpio, i2c1(sck), ge1(rxd2), ua0(cts), sd0(d1), dev(a2)
 mpp40         40       gpio, i2c1(sda), ge1(rxd3), ua0(rts), sd0(d2), dev(ad6)
-mpp41         41       gpio, ua1(rxd), ge1(rxctl), ua0(cts), spi1(cs3), dev(burst/last)
+mpp41         41       gpio, ua1(rxd), ge1(rxctl), ua0(cts), spi1(cs3), dev(burst/last), nand(rb0)
 mpp42         42       gpio, ua1(txd), ua0(rts), dev(ad7)
-mpp43         43       gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout)
+mpp43         43       gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nand(rb1)
 mpp44         44       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3(prsnt) [3]
 mpp45         45       gpio, ref(clk_out0), pcie0(rstout)
 mpp46         46       gpio, ref(clk_out1), pcie0(rstout)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 8b401b5..ac8f297 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -268,7 +268,8 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "ge1",   "rxctl",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua0",   "cts",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",  "cs3",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",   "burst/last", V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dev",   "burst/last", V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "nand",  "rb0",        V_88F6810_PLUS)),
 	MPP_MODE(42,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ua1",   "txd",        V_88F6810_PLUS),
@@ -280,7 +281,8 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "dram",  "vttctrl",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "dram",  "deccerr",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",  "cs2",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",   "clkout",     V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dev",   "clkout",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "nand",  "rb1",        V_88F6810_PLUS)),
 	MPP_MODE(44,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
-- 
2.1.0
