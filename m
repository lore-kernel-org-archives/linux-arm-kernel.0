From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:24 +0200
Subject: [PATCH 32/34] pinctrl: mvebu: armada-39x: add missing PCIe functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-33-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version of the Armada 39x datasheet documents several new
PCIe related functions on various MPP pins. This commit adds the
description of these new functions to the Armada 39x pinctrl driver as
well as to its DT binding documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt        | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c                            | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index 1dd76e9..2e4725f 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -27,10 +27,10 @@ mpp9	9	gpio, dev(ad11), ptp(clk)
 mpp10	10	gpio, dev(ad12), ptp(evreq)
 mpp11	11	gpio, dev(ad13), led(clk)
 mpp12	12	gpio, pcie0(rstout), dev(ad14), led(stb)
-mpp13	13	gpio, dev(ad15), led(data)
+mpp13	13	gpio, dev(ad15), pcie2(clkreq), led(data)
 mpp14	14	gpio, dram(vttctrl), dev(we1), ua1(txd)
 mpp15	15	gpio, pcie0(rstout), spi0(mosi), i2c1(sck)
-mpp16	16	gpio, dram(deccerr), spi0(miso), i2c1(sda)
+mpp16	16	gpio, dram(deccerr), spi0(miso), pcie0(clkreq), i2c1(sda)
 mpp17	17	gpio, ua1(rxd), spi0(sck), smi(mdio)
 mpp18	18	gpio, ua1(txd), spi0(cs0), i2c2(sck)
 mpp19	19	gpio, sata1(prsnt) [1], ua0(cts), ua1(rxd), i2c2(sda)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 08ee427..afab0c1 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -95,6 +95,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(13,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad15",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(6, "pcie2",   "clkreq",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "led",     "data",     V_88F6920_PLUS)),
 	MPP_MODE(14,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -110,6 +111,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "dram",    "deccerr",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",    "miso",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "pcie0",   "clkreq",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c1",    "sda",      V_88F6920_PLUS)),
 	MPP_MODE(17,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-- 
2.1.0
