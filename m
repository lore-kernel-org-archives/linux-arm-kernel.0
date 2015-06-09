From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:03 +0200
Subject: [PATCH 11/34] pinctrl: mvebu: armada-{38x, 39x,
 xp}: normalize naming of DRAM functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes the dram functions naming (both the name and
subname) consistent accross SoC, by using:

  dram(vttctrl)
  dram(deccerr)

in all Marvell SoCs.

Due to the change to the name, it changes the DT binding, but these
functions are not used by any in-tree Device Tree file, and are very
unlikely to be used by anyone.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-38x-pinctrl.txt      | 14 +++++++-------
 .../bindings/pinctrl/marvell,armada-39x-pinctrl.txt      | 14 +++++++-------
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt       |  6 +++---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c               | 16 ++++++++--------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c               | 16 ++++++++--------
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                |  6 +++---
 6 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 4fe6340..4fb82c1 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -29,9 +29,9 @@ mpp10         10       gpio, ge0(txd3), dev(ad12)
 mpp11         11       gpio, ge0(txctl), dev(ad13)
 mpp12         12       gpio, ge0(rxd0), pcie0(rstout), spi0(cs1), dev(ad14), pcie3(clkreq)
 mpp13         13       gpio, ge0(rxd1), pcie0(clkreq), pcie1(clkreq) [1], spi0(cs2), dev(ad15), pcie2(clkreq)
-mpp14         14       gpio, ge0(rxd2), ptp(clk), m(vtt_ctrl), spi0(cs3), dev(wen1), pcie3(clkreq)
+mpp14         14       gpio, ge0(rxd2), ptp(clk), dram(vttctrl), spi0(cs3), dev(wen1), pcie3(clkreq)
 mpp15         15       gpio, ge0(rxd3), ge(mdc slave), pcie0(rstout), spi0(mosi)
-mpp16         16       gpio, ge0(rxctl), ge(mdio slave), m(decc_err), spi0(miso), pcie0(clkreq), pcie1(clkreq) [1]
+mpp16         16       gpio, ge0(rxctl), ge(mdio slave), dram(deccerr), spi0(miso), pcie0(clkreq), pcie1(clkreq) [1]
 mpp17         17       gpio, ge0(rxclk), ptp(clk), ua1(rxd), spi0(sck), sata1(prsnt)
 mpp18         18       gpio, ge0(rxerr), ptp(trig), ua1(txd), spi0(cs0)
 mpp19         19       gpio, ge0(col), ptp(evreq), ge0(txerr), sata1(prsnt), ua0(cts)
@@ -48,7 +48,7 @@ mpp29         29       gpio, ge1(txd1), dev(ale0)
 mpp30         30       gpio, ge1(txd2), dev(oen)
 mpp31         31       gpio, ge1(txd3), dev(ale1)
 mpp32         32       gpio, ge1(txctl), dev(wen0)
-mpp33         33       gpio, m(decc_err), dev(ad3)
+mpp33         33       gpio, dram(deccerr), dev(ad3)
 mpp34         34       gpio, dev(ad1)
 mpp35         35       gpio, ref(clk_out1), dev(a1)
 mpp36         36       gpio, ptp(trig), dev(a0)
@@ -58,20 +58,20 @@ mpp39         39       gpio, i2c1(sck), ge1(rxd2), ua0(cts), sd0(d1), dev(a2)
 mpp40         40       gpio, i2c1(sda), ge1(rxd3), ua0(rts), sd0(d2), dev(ad6)
 mpp41         41       gpio, ua1(rxd), ge1(rxctl), ua0(cts), spi1(cs3), dev(burst/last)
 mpp42         42       gpio, ua1(txd), ua0(rts), dev(ad7)
-mpp43         43       gpio, pcie0(clkreq), m(vtt_ctrl), m(decc_err), spi1(cs2), dev(clkout)
+mpp43         43       gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout)
 mpp44         44       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3(prsnt) [3]
 mpp45         45       gpio, ref(clk_out0), pcie0(rstout)
 mpp46         46       gpio, ref(clk_out1), pcie0(rstout)
 mpp47         47       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3(prsnt) [2]
-mpp48         48       gpio, sata0(prsnt), m(vtt_ctrl), tdm2c(pclk), audio(mclk), sd0(d4), pcie0(clkreq)
+mpp48         48       gpio, sata0(prsnt), dram(vttctrl), tdm2c(pclk), audio(mclk), sd0(d4), pcie0(clkreq)
 mpp49         49       gpio, sata2(prsnt) [2], sata3(prsnt) [2], tdm2c(fsync), audio(lrclk), sd0(d5), pcie1(clkreq)
 mpp50         50       gpio, pcie0(rstout), tdm2c(drx), audio(extclk), sd0(cmd)
-mpp51         51       gpio, tdm2c(dtx), audio(sdo), m(decc_err)
+mpp51         51       gpio, tdm2c(dtx), audio(sdo), dram(deccerr)
 mpp52         52       gpio, pcie0(rstout), tdm2c(intn), audio(sdi), sd0(d6)
 mpp53         53       gpio, sata1(prsnt), sata0(prsnt), tdm2c(rstn), audio(bclk), sd0(d7)
 mpp54         54       gpio, sata0(prsnt), sata1(prsnt), pcie0(rstout), ge0(txerr), sd0(d3)
 mpp55         55       gpio, ua1(cts), ge(mdio), pcie1(clkreq) [1], spi1(cs1), sd0(d0)
-mpp56         56       gpio, ua1(rts), ge(mdc), m(decc_err), spi1(mosi)
+mpp56         56       gpio, ua1(rts), ge(mdc), dram(deccerr), spi1(mosi)
 mpp57         57       gpio, spi1(sck), sd0(clk)
 mpp58         58       gpio, pcie1(clkreq) [1], i2c1(sck), pcie2(clkreq), spi1(miso), sd0(d1)
 mpp59         59       gpio, pcie0(rstout), i2c1(sda), spi1(cs0), sd0(d2)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index 182a059..8271cd2 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -28,9 +28,9 @@ mpp10	10	gpio, dev(ad12), ptp(evreq)
 mpp11	11	gpio, dev(ad13), led(clk)
 mpp12	12	gpio, pcie0(rstout), dev(ad14), led(stb)
 mpp13	13	gpio, dev(ad15), led(data)
-mpp14	14	gpio, m(vtt), dev(wen1), ua1(txd)
+mpp14	14	gpio, dram(vttctrl), dev(wen1), ua1(txd)
 mpp15	15	gpio, pcie0(rstout), spi0(mosi), i2c1(sck)
-mpp16	16	gpio, m(decc), spi0(miso), i2c1(sda)
+mpp16	16	gpio, dram(deccerr), spi0(miso), i2c1(sda)
 mpp17	17	gpio, ua1(rxd), spi0(sck), smi(mdio)
 mpp18	18	gpio, ua1(txd), spi0(cs0), i2c2(sck)
 mpp19	19	gpio, sata1(present) [1], ua0(cts), ua1(rxd), i2c2(sda)
@@ -47,7 +47,7 @@ mpp29	29	gpio, dev(ale0), ge(txd1)
 mpp30	30	gpio, dev(oen), ge(txd2)
 mpp31	31	gpio, dev(ale1), ge(txd3)
 mpp32	32	gpio, dev(wen0), ge(txctl)
-mpp33	33	gpio, m(decc), dev(ad3)
+mpp33	33	gpio, dram(deccerr), dev(ad3)
 mpp34	34	gpio, dev(ad1)
 mpp35	35	gpio, ref(clk), dev(a1)
 mpp36	36	gpio, dev(a0)
@@ -57,20 +57,20 @@ mpp39	39	gpio, i2c1(sck), ua0(cts), sd(d1), dev(a2), ge(rxd2)
 mpp40	40	gpio, i2c1(sda), ua0(rts), sd(d2), dev(ad6), ge(rxd3)
 mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burstn), nd(rbn0), ge(rxctl)
 mpp42	42	gpio, ua1(txd), ua0(rts), dev(ad7)
-mpp43	43	gpio, pcie0(clkreq), m(vtt), m(decc), spi1(cs2), dev(clkout), nd(rbn1)
+mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nd(rbn1)
 mpp44	44	gpio, sata0(present) [1], sata1(present) [1], led(clk)
 mpp45	45	gpio, ref(clk), pcie0(rstout), ua1(rxd)
 mpp46	46	gpio, ref(clk), pcie0(rstout), ua1(txd), led(stb)
 mpp47	47	gpio, sata0(present) [1], sata1(present) [1], led(data)
-mpp48	48	gpio, sata0(present) [1], m(vtt), tdm(pclk) [1], audio(mclk) [1], sd(d4), pcie0(clkreq), ua1(txd)
+mpp48	48	gpio, sata0(present) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1], sd(d4), pcie0(clkreq), ua1(txd)
 mpp49	49	gpio, tdm(fsync) [1], audio(lrclk) [1], sd(d5), ua2(rxd)
 mpp50	50	gpio, pcie0(rstout), tdm(drx) [1], audio(extclk) [1], sd(cmd), ua2(rxd)
-mpp51	51	gpio, tdm(dtx) [1], audio(sdo) [1], m(decc), ua2(txd)
+mpp51	51	gpio, tdm(dtx) [1], audio(sdo) [1], dram(deccerr), ua2(txd)
 mpp52	52	gpio, pcie0(rstout), tdm(intn) [1], audio(sdi) [1], sd(d6), i2c3(sck)
 mpp53	53	gpio, sata1(present) [1], sata0(present) [1], tdm(rstn) [1], audio(bclk) [1], sd(d7), i2c3(sda)
 mpp54	54	gpio, sata0(present) [1], sata1(present) [1], pcie0(rstout), sd(d3), ua3(txd)
 mpp55	55	gpio, ua1(cts), spi1(cs1), sd(d0), ua1(rxd), ua3(rxd)
-mpp56	56	gpio, ua1(rts), m(decc), spi1(mosi), ua1(txd)
+mpp56	56	gpio, ua1(rts), dram(deccerr), spi1(mosi), ua1(txd)
 mpp57	57	gpio, spi1(sck), sd(clk), ua1(txd)
 mpp58	58	gpio, i2c1(sck), pcie2(clkreq), spi1(miso), sd(d1), ua1(rxd)
 mpp59	59	gpio, pcie0(rstout), i2c1(sda), spi1(cs0), sd(d2)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index 96e7744..cefca17 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -39,7 +39,7 @@ mpp17         17       gpio, ge0(col), ge1(txctl), lcd(d17)
 mpp18         18       gpio, ge0(rxerr), ge1(rxd0), lcd(d18), ptp(trig)
 mpp19         19       gpio, ge0(crs), ge1(rxd1), lcd(d19), ptp(evreq)
 mpp20         20       gpio, ge0(rxd4), ge1(rxd2), lcd(d20), ptp(clk)
-mpp21         21       gpio, ge0(rxd5), ge1(rxd3), lcd(d21), mem(bat)
+mpp21         21       gpio, ge0(rxd5), ge1(rxd3), lcd(d21), dram(bat)
 mpp22         22       gpio, ge0(rxd6), ge1(rxctl), lcd(d22), sata0(prsnt)
 mpp23         23       gpio, ge0(rxd7), ge1(rxclk), lcd(d23), sata1(prsnt)
 mpp24         24       gpio, lcd(hsync), sata1(prsnt), tdm(rst)
@@ -51,7 +51,7 @@ mpp29         29       gpio, lcd(ref-clk), tdm(int0), ptp(clk)
 mpp30         30       gpio, tdm(int1), sd0(clk)
 mpp31         31       gpio, tdm(int2), sd0(cmd)
 mpp32         32       gpio, tdm(int3), sd0(d0)
-mpp33         33       gpio, tdm(int4), sd0(d1), mem(bat)
+mpp33         33       gpio, tdm(int4), sd0(d1), dram(bat)
 mpp34         34       gpio, tdm(int5), sd0(d2), sata0(prsnt)
 mpp35         35       gpio, tdm(int6), sd0(d3), sata1(prsnt)
 mpp36         36       gpio, spi(mosi)
@@ -64,7 +64,7 @@ mpp41         41       gpio, spi(cs2), uart2(rts), lcd(vga-vsync), sata1(prsnt),
 mpp42         42       gpio, uart2(rxd), uart0(cts), tdm(int7), tdm-1(timer)
 mpp43         43       gpio, uart2(txd), uart0(rts), spi(cs3), pcie(rstout)
 mpp44         44       gpio, uart2(cts), uart3(rxd), spi(cs4), pcie(clkreq2),
-                       mem(bat)
+                       dram(bat)
 mpp45         45       gpio, uart2(rts), uart3(txd), spi(cs5), sata1(prsnt)
 mpp46         46       gpio, uart3(rts), uart1(rts), spi(cs6), sata0(prsnt)
 mpp47         47       gpio, uart3(cts), uart1(cts), spi(cs7), pcie(clkreq3),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index eb4b0d8..2b04923 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -109,7 +109,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ge0",   "rxd2",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ptp",   "clk",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",     "vtt_ctrl",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",  "vttctrl",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",  "cs3",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",   "wen1",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(6, "pcie3", "clkreq",     V_88F6810_PLUS)),
@@ -123,7 +123,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ge0",   "rxctl",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ge",    "mdio slave", V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",  "deccerr",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",  "miso",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "pcie0", "clkreq",     V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(6, "pcie1", "clkreq",     V_88F6820_PLUS)),
@@ -220,7 +220,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(5, "dev",   "wen0",       V_88F6810_PLUS)),
 	MPP_MODE(33,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(1, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "dram",  "deccerr",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",   "ad3",        V_88F6810_PLUS)),
 	MPP_MODE(34,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
@@ -275,8 +275,8 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 	MPP_MODE(43,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0", "clkreq",     V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(2, "m",     "vtt_ctrl",   V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "dram",  "vttctrl",    V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",  "deccerr",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",  "cs2",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",   "clkout",     V_88F6810_PLUS)),
 	MPP_MODE(44,
@@ -302,7 +302,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(2, "m",     "vtt_ctrl",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "dram",  "vttctrl",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm2c", "pclk",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "mclk",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd0",   "d4",         V_88F6810_PLUS),
@@ -325,7 +325,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm2c", "dtx",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "sdo",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "m",     "decc_err",   V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dram",  "deccerr",    V_88F6810_PLUS)),
 	MPP_MODE(52,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
@@ -357,7 +357,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ua1",   "rts",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ge",    "mdc",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",     "decc_err",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",  "deccerr",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",  "mosi",       V_88F6810_PLUS)),
 	MPP_MODE(57,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 4cf7024..7cbc3fb 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -98,7 +98,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "led",     "data",     V_88F6920_PLUS)),
 	MPP_MODE(14,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",       "vtt",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",    "vttctrl",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "wen1",     V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua1",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(15,
@@ -108,7 +108,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "i2c1",    "sck",      V_88F6920_PLUS)),
 	MPP_MODE(16,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",       "decc",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",    "deccerr",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",    "miso",     V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c1",    "sda",      V_88F6920_PLUS)),
 	MPP_MODE(17,
@@ -198,7 +198,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(8, "ge",      "txctl",    V_88F6920_PLUS)),
 	MPP_MODE(33,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "m",       "decc",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(1, "dram",    "deccerr",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad3",      V_88F6920_PLUS)),
 	MPP_MODE(34,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -251,8 +251,8 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(43,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0",   "clkreq",   V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(2, "m",       "vtt",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",       "decc",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(2, "dram",    "vttctrl",  V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",    "deccerr",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "cs2",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "clkout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "nd",      "rbn1",     V_88F6920_PLUS)),
@@ -280,7 +280,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0",   "present",  V_88F6928),
-		 MPP_VAR_FUNCTION(2, "m",       "vtt",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(2, "dram",    "vttctrl",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "pclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "mclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(5, "sd",      "d4",       V_88F6920_PLUS),
@@ -303,7 +303,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "tdm",     "dtx",      V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "sdo",      V_88F6928),
-		 MPP_VAR_FUNCTION(5, "m",       "decc",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "dram",    "deccerr",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua2",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(52,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -337,7 +337,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(56,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "ua1",     "rts",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "m",       "decc",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(3, "dram",    "deccerr",  V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "mosi",     V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(57,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index d7cdb14..93b0485 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -152,7 +152,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "ge0", "rxd5",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "ge1", "rxd3",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "mem", "bat",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "dram", "bat",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "d21",        V_MV78230_PLUS)),
 	MPP_MODE(22,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
@@ -211,7 +211,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "sd0", "d1",         V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "tdm", "int4",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "mem", "bat",        V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dram", "bat",       V_MV78230_PLUS)),
 	MPP_MODE(34,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "sd0", "d2",         V_MV78230_PLUS),
@@ -264,7 +264,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x1, "uart2", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart3", "rxd",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "spi", "cs4",        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "mem", "bat",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dram", "bat",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq2",   V_MV78230_PLUS)),
 	MPP_MODE(45,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-- 
2.1.0
