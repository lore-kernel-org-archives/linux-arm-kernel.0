From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:04 +0200
Subject: [PATCH 12/34] pinctrl: mvebu: armada-39x: normalize SATA present
 functionality naming
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes the naming of SATA related MPP functions consistent
accross SoCs by adjusting the Armada 39x definition to use "prsnt"
instead of "present".

Since only the subnames are changed, the DT binding is not modified at
all.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../pinctrl/marvell,armada-39x-pinctrl.txt         | 16 +++++++--------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c         | 24 +++++++++++-----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index 8271cd2..46f7a5d 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -33,9 +33,9 @@ mpp15	15	gpio, pcie0(rstout), spi0(mosi), i2c1(sck)
 mpp16	16	gpio, dram(deccerr), spi0(miso), i2c1(sda)
 mpp17	17	gpio, ua1(rxd), spi0(sck), smi(mdio)
 mpp18	18	gpio, ua1(txd), spi0(cs0), i2c2(sck)
-mpp19	19	gpio, sata1(present) [1], ua0(cts), ua1(rxd), i2c2(sda)
-mpp20	20	gpio, sata0(present) [1], ua0(rts), ua1(txd), smi(mdc)
-mpp21	21	gpio, spi0(cs1), sata0(present) [1], sd(cmd), dev(bootcs), ge(rxd0)
+mpp19	19	gpio, sata1(prsnt) [1], ua0(cts), ua1(rxd), i2c2(sda)
+mpp20	20	gpio, sata0(prsnt) [1], ua0(rts), ua1(txd), smi(mdc)
+mpp21	21	gpio, spi0(cs1), sata0(prsnt) [1], sd(cmd), dev(bootcs), ge(rxd0)
 mpp22	22	gpio, spi0(mosi), dev(ad0)
 mpp23	23	gpio, spi0(sck), dev(ad2)
 mpp24	24	gpio, spi0(miso), ua0(cts), ua1(rxd), sd(d4), dev(readyn)
@@ -58,17 +58,17 @@ mpp40	40	gpio, i2c1(sda), ua0(rts), sd(d2), dev(ad6), ge(rxd3)
 mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burstn), nd(rbn0), ge(rxctl)
 mpp42	42	gpio, ua1(txd), ua0(rts), dev(ad7)
 mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nd(rbn1)
-mpp44	44	gpio, sata0(present) [1], sata1(present) [1], led(clk)
+mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(clk)
 mpp45	45	gpio, ref(clk), pcie0(rstout), ua1(rxd)
 mpp46	46	gpio, ref(clk), pcie0(rstout), ua1(txd), led(stb)
-mpp47	47	gpio, sata0(present) [1], sata1(present) [1], led(data)
-mpp48	48	gpio, sata0(present) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1], sd(d4), pcie0(clkreq), ua1(txd)
+mpp47	47	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(data)
+mpp48	48	gpio, sata0(prsnt) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1], sd(d4), pcie0(clkreq), ua1(txd)
 mpp49	49	gpio, tdm(fsync) [1], audio(lrclk) [1], sd(d5), ua2(rxd)
 mpp50	50	gpio, pcie0(rstout), tdm(drx) [1], audio(extclk) [1], sd(cmd), ua2(rxd)
 mpp51	51	gpio, tdm(dtx) [1], audio(sdo) [1], dram(deccerr), ua2(txd)
 mpp52	52	gpio, pcie0(rstout), tdm(intn) [1], audio(sdi) [1], sd(d6), i2c3(sck)
-mpp53	53	gpio, sata1(present) [1], sata0(present) [1], tdm(rstn) [1], audio(bclk) [1], sd(d7), i2c3(sda)
-mpp54	54	gpio, sata0(present) [1], sata1(present) [1], pcie0(rstout), sd(d3), ua3(txd)
+mpp53	53	gpio, sata1(prsnt) [1], sata0(prsnt) [1], tdm(rstn) [1], audio(bclk) [1], sd(d7), i2c3(sda)
+mpp54	54	gpio, sata0(prsnt) [1], sata1(prsnt) [1], pcie0(rstout), sd(d3), ua3(txd)
 mpp55	55	gpio, ua1(cts), spi1(cs1), sd(d0), ua1(rxd), ua3(rxd)
 mpp56	56	gpio, ua1(rts), dram(deccerr), spi1(mosi), ua1(txd)
 mpp57	57	gpio, spi1(sck), sd(clk), ua1(txd)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 7cbc3fb..f6cc7f1 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -123,20 +123,20 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "i2c2",    "sck",      V_88F6920_PLUS)),
 	MPP_MODE(19,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sata1",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(4, "sata1",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(5, "ua0",     "cts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "rxd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c2",    "sda",      V_88F6920_PLUS)),
 	MPP_MODE(20,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sata0",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(4, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(5, "ua0",     "rts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "txd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "smi",     "mdc",      V_88F6920_PLUS)),
 	MPP_MODE(21,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",    "cs1",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "sata0",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(3, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(4, "sd",      "cmd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "bootcs",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd0",     V_88F6920_PLUS)),
@@ -258,8 +258,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(6, "nd",      "rbn1",     V_88F6920_PLUS)),
 	MPP_MODE(44,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "present",  V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata1",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(7, "led",     "clk",      V_88F6920_PLUS)),
 	MPP_MODE(45,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -274,12 +274,12 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "led",     "stb",      V_88F6920_PLUS)),
 	MPP_MODE(47,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "present",  V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata1",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(7, "led",     "data",     V_88F6920_PLUS)),
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(2, "dram",    "vttctrl",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "pclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "mclk",     V_88F6928),
@@ -314,16 +314,16 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sck",      V_88F6920_PLUS)),
 	MPP_MODE(53,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata1",   "present",  V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata0",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata1",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(2, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(3, "tdm",     "rstn",     V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "bclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(5, "sd",      "d7",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sda",      V_88F6920_PLUS)),
 	MPP_MODE(54,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "sata0",   "present",  V_88F6928),
-		 MPP_VAR_FUNCTION(2, "sata1",   "present",  V_88F6928),
+		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
+		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(3, "pcie0",   "rstout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd",      "d3",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua3",     "txd",      V_88F6920_PLUS)),
-- 
2.1.0
