From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:05 +0200
Subject: [PATCH 13/34] pinctrl: mvebu: armada-39x: normalize SDIO pin naming
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be consistent with the datasheet and some other SoCs, this
commit renames the SDIO pins of the Armada 39x from "sd" to "sd0".

While this changes the DT binding, this is not a problem since Armada
39x is a brand new SoC which isn't used in production yet (so now is
the right time to fix such things).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../pinctrl/marvell,armada-39x-pinctrl.txt         | 40 +++++++++++-----------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c         | 40 +++++++++++-----------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index 46f7a5d..d36cb94 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -35,14 +35,14 @@ mpp17	17	gpio, ua1(rxd), spi0(sck), smi(mdio)
 mpp18	18	gpio, ua1(txd), spi0(cs0), i2c2(sck)
 mpp19	19	gpio, sata1(prsnt) [1], ua0(cts), ua1(rxd), i2c2(sda)
 mpp20	20	gpio, sata0(prsnt) [1], ua0(rts), ua1(txd), smi(mdc)
-mpp21	21	gpio, spi0(cs1), sata0(prsnt) [1], sd(cmd), dev(bootcs), ge(rxd0)
+mpp21	21	gpio, spi0(cs1), sata0(prsnt) [1], sd0(cmd), dev(bootcs), ge(rxd0)
 mpp22	22	gpio, spi0(mosi), dev(ad0)
 mpp23	23	gpio, spi0(sck), dev(ad2)
-mpp24	24	gpio, spi0(miso), ua0(cts), ua1(rxd), sd(d4), dev(readyn)
-mpp25	25	gpio, spi0(cs0), ua0(rts), ua1(txd), sd(d5), dev(cs0)
-mpp26	26	gpio, spi0(cs2), i2c1(sck), sd(d6), dev(cs1)
-mpp27	27	gpio, spi0(cs3), i2c1(sda), sd(d7), dev(cs2), ge(txclkout)
-mpp28	28	gpio, sd(clk), dev(ad5), ge(txd0)
+mpp24	24	gpio, spi0(miso), ua0(cts), ua1(rxd), sd0(d4), dev(readyn)
+mpp25	25	gpio, spi0(cs0), ua0(rts), ua1(txd), sd0(d5), dev(cs0)
+mpp26	26	gpio, spi0(cs2), i2c1(sck), sd0(d6), dev(cs1)
+mpp27	27	gpio, spi0(cs3), i2c1(sda), sd0(d7), dev(cs2), ge(txclkout)
+mpp28	28	gpio, sd0(clk), dev(ad5), ge(txd0)
 mpp29	29	gpio, dev(ale0), ge(txd1)
 mpp30	30	gpio, dev(oen), ge(txd2)
 mpp31	31	gpio, dev(ale1), ge(txd3)
@@ -51,10 +51,10 @@ mpp33	33	gpio, dram(deccerr), dev(ad3)
 mpp34	34	gpio, dev(ad1)
 mpp35	35	gpio, ref(clk), dev(a1)
 mpp36	36	gpio, dev(a0)
-mpp37	37	gpio, sd(d3), dev(ad8), ge(rxclk)
-mpp38	38	gpio, ref(clk), sd(d0), dev(ad4), ge(rxd1)
-mpp39	39	gpio, i2c1(sck), ua0(cts), sd(d1), dev(a2), ge(rxd2)
-mpp40	40	gpio, i2c1(sda), ua0(rts), sd(d2), dev(ad6), ge(rxd3)
+mpp37	37	gpio, sd0(d3), dev(ad8), ge(rxclk)
+mpp38	38	gpio, ref(clk), sd0(d0), dev(ad4), ge(rxd1)
+mpp39	39	gpio, i2c1(sck), ua0(cts), sd0(d1), dev(a2), ge(rxd2)
+mpp40	40	gpio, i2c1(sda), ua0(rts), sd0(d2), dev(ad6), ge(rxd3)
 mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burstn), nd(rbn0), ge(rxctl)
 mpp42	42	gpio, ua1(txd), ua0(rts), dev(ad7)
 mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nd(rbn1)
@@ -62,17 +62,17 @@ mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(clk)
 mpp45	45	gpio, ref(clk), pcie0(rstout), ua1(rxd)
 mpp46	46	gpio, ref(clk), pcie0(rstout), ua1(txd), led(stb)
 mpp47	47	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(data)
-mpp48	48	gpio, sata0(prsnt) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1], sd(d4), pcie0(clkreq), ua1(txd)
-mpp49	49	gpio, tdm(fsync) [1], audio(lrclk) [1], sd(d5), ua2(rxd)
-mpp50	50	gpio, pcie0(rstout), tdm(drx) [1], audio(extclk) [1], sd(cmd), ua2(rxd)
+mpp48	48	gpio, sata0(prsnt) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1], sd0(d4), pcie0(clkreq), ua1(txd)
+mpp49	49	gpio, tdm(fsync) [1], audio(lrclk) [1], sd0(d5), ua2(rxd)
+mpp50	50	gpio, pcie0(rstout), tdm(drx) [1], audio(extclk) [1], sd0(cmd), ua2(rxd)
 mpp51	51	gpio, tdm(dtx) [1], audio(sdo) [1], dram(deccerr), ua2(txd)
-mpp52	52	gpio, pcie0(rstout), tdm(intn) [1], audio(sdi) [1], sd(d6), i2c3(sck)
-mpp53	53	gpio, sata1(prsnt) [1], sata0(prsnt) [1], tdm(rstn) [1], audio(bclk) [1], sd(d7), i2c3(sda)
-mpp54	54	gpio, sata0(prsnt) [1], sata1(prsnt) [1], pcie0(rstout), sd(d3), ua3(txd)
-mpp55	55	gpio, ua1(cts), spi1(cs1), sd(d0), ua1(rxd), ua3(rxd)
+mpp52	52	gpio, pcie0(rstout), tdm(intn) [1], audio(sdi) [1], sd0(d6), i2c3(sck)
+mpp53	53	gpio, sata1(prsnt) [1], sata0(prsnt) [1], tdm(rstn) [1], audio(bclk) [1], sd0(d7), i2c3(sda)
+mpp54	54	gpio, sata0(prsnt) [1], sata1(prsnt) [1], pcie0(rstout), sd0(d3), ua3(txd)
+mpp55	55	gpio, ua1(cts), spi1(cs1), sd0(d0), ua1(rxd), ua3(rxd)
 mpp56	56	gpio, ua1(rts), dram(deccerr), spi1(mosi), ua1(txd)
-mpp57	57	gpio, spi1(sck), sd(clk), ua1(txd)
-mpp58	58	gpio, i2c1(sck), pcie2(clkreq), spi1(miso), sd(d1), ua1(rxd)
-mpp59	59	gpio, pcie0(rstout), i2c1(sda), spi1(cs0), sd(d2)
+mpp57	57	gpio, spi1(sck), sd0(clk), ua1(txd)
+mpp58	58	gpio, i2c1(sck), pcie2(clkreq), spi1(miso), sd0(d1), ua1(rxd)
+mpp59	59	gpio, pcie0(rstout), i2c1(sda), spi1(cs0), sd0(d2)
 
 [1]: only available on 88F6928
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index f6cc7f1..fa3042a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -137,7 +137,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",    "cs1",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "sata0",   "prsnt",    V_88F6928),
-		 MPP_VAR_FUNCTION(4, "sd",      "cmd",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "cmd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "bootcs",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd0",     V_88F6920_PLUS)),
 	MPP_MODE(22,
@@ -153,31 +153,31 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(1, "spi0",    "miso",     V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(2, "ua0",     "cts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua1",     "rxd",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d4",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d4",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "readyn",   V_88F6920_PLUS)),
 	MPP_MODE(25,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",    "cs0",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(2, "ua0",     "rts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua1",     "txd",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d5",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d5",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "cs0",      V_88F6920_PLUS)),
 	MPP_MODE(26,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",    "cs2",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "i2c1",    "sck",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d6",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d6",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "cs1",      V_88F6920_PLUS)),
 	MPP_MODE(27,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",    "cs3",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "i2c1",    "sda",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d7",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d7",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "cs2",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "txclkout", V_88F6920_PLUS)),
 	MPP_MODE(28,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "clk",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "clk",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad5",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "txd0",     V_88F6920_PLUS)),
 	MPP_MODE(29,
@@ -212,27 +212,27 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(5, "dev",     "a0",       V_88F6920_PLUS)),
 	MPP_MODE(37,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d3",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d3",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad8",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxclk",    V_88F6920_PLUS)),
 	MPP_MODE(38,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ref",     "clk",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d0",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d0",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad4",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd1",     V_88F6920_PLUS)),
 	MPP_MODE(39,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "i2c1",    "sck",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua0",     "cts",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d1",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d1",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "a2",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd2",     V_88F6920_PLUS)),
 	MPP_MODE(40,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "i2c1",    "sda",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua0",     "rts",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(4, "sd",      "d2",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(4, "sd0",     "d2",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad6",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd3",     V_88F6920_PLUS)),
 	MPP_MODE(41,
@@ -283,21 +283,21 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "dram",    "vttctrl",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "pclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "mclk",     V_88F6928),
-		 MPP_VAR_FUNCTION(5, "sd",      "d4",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d4",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "pcie0",   "clkreq",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua1",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(49,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "fsync",    V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "lrclk",    V_88F6928),
-		 MPP_VAR_FUNCTION(5, "sd",      "d5",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d5",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua2",     "rxd",      V_88F6920_PLUS)),
 	MPP_MODE(50,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0",   "rstout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "drx",      V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "extclk",   V_88F6928),
-		 MPP_VAR_FUNCTION(5, "sd",      "cmd",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "cmd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua2",     "rxd",      V_88F6920_PLUS)),
 	MPP_MODE(51,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -310,7 +310,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(1, "pcie0",   "rstout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "intn",     V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "sdi",      V_88F6928),
-		 MPP_VAR_FUNCTION(5, "sd",      "d6",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d6",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sck",      V_88F6920_PLUS)),
 	MPP_MODE(53,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -318,20 +318,20 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(3, "tdm",     "rstn",     V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "bclk",     V_88F6928),
-		 MPP_VAR_FUNCTION(5, "sd",      "d7",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d7",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sda",      V_88F6920_PLUS)),
 	MPP_MODE(54,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(2, "sata1",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(3, "pcie0",   "rstout",   V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd",      "d3",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d3",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua3",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(55,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "ua1",     "cts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "cs1",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd",      "d0",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d0",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "rxd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua3",     "rxd",      V_88F6920_PLUS)),
 	MPP_MODE(56,
@@ -343,21 +343,21 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(57,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "sck",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd",      "clk",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "clk",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(58,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(2, "i2c1",    "sck",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "pcie2",   "clkreq",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "miso",     V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd",      "d1",       V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d1",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "rxd",      V_88F6920_PLUS)),
 	MPP_MODE(59,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0",   "rstout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(2, "i2c1",    "sda",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "cs0",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "sd",      "d2",       V_88F6920_PLUS)),
+		 MPP_VAR_FUNCTION(5, "sd0",     "d2",       V_88F6920_PLUS)),
 };
 
 static struct mvebu_pinctrl_soc_info armada_39x_pinctrl_info;
-- 
2.1.0
