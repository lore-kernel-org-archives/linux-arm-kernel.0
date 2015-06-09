From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:20 +0200
Subject: [PATCH 28/34] pinctrl: mvebu: armada-38x: add sata functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-29-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version of the Armada 38x datasheet documents several new
SATA related functions on various MPP pins. This commit adds the
description of these new functions to the Armada 38x pinctrl driver as
well as to its DT binding documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt      | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c                          | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 203220d..066e26a 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -32,11 +32,11 @@ mpp13         13       gpio, ge0(rxd1), pcie0(clkreq), pcie1(clkreq) [1], spi0(c
 mpp14         14       gpio, ge0(rxd2), ptp(clk), dram(vttctrl), spi0(cs3), dev(we1), pcie3(clkreq)
 mpp15         15       gpio, ge0(rxd3), ge(mdc slave), pcie0(rstout), spi0(mosi)
 mpp16         16       gpio, ge0(rxctl), ge(mdio slave), dram(deccerr), spi0(miso), pcie0(clkreq), pcie1(clkreq) [1]
-mpp17         17       gpio, ge0(rxclk), ptp(clk), ua1(rxd), spi0(sck), sata1(prsnt)
+mpp17         17       gpio, ge0(rxclk), ptp(clk), ua1(rxd), spi0(sck), sata1(prsnt), sata0(prsnt)
 mpp18         18       gpio, ge0(rxerr), ptp(trig), ua1(txd), spi0(cs0)
 mpp19         19       gpio, ge0(col), ptp(evreq), ge0(txerr), sata1(prsnt), ua0(cts)
 mpp20         20       gpio, ge0(txclk), ptp(clk), sata0(prsnt), ua0(rts)
-mpp21         21       gpio, spi0(cs1), ge1(rxd0), sata0(prsnt), sd0(cmd), dev(bootcs)
+mpp21         21       gpio, spi0(cs1), ge1(rxd0), sata0(prsnt), sd0(cmd), dev(bootcs), sata1(prsnt)
 mpp22         22       gpio, spi0(mosi), dev(ad0)
 mpp23         23       gpio, spi0(sck), dev(ad2)
 mpp24         24       gpio, spi0(miso), ua0(cts), ua1(rxd), sd0(d4), dev(ready)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index b5006f7..8b401b5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -133,7 +133,8 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "ptp",   "clk",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua1",   "rxd",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",  "sck",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "sata1", "prsnt",      V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "sata1", "prsnt",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "sata0", "prsnt",      V_88F6810_PLUS)),
 	MPP_MODE(18,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ge0",   "rxerr",      V_88F6810_PLUS),
@@ -161,7 +162,8 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "ge1",   "rxd0",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "sata0", "prsnt",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "sd0",   "cmd",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",   "bootcs",     V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dev",   "bootcs",     V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "sata1", "prsnt",      V_88F6810_PLUS)),
 	MPP_MODE(22,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",  "mosi",       V_88F6810_PLUS),
-- 
2.1.0
