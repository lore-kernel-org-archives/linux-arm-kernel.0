From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:06 +0200
Subject: [PATCH 14/34] pinctrl: mvebu: armada-{370, 375, 38x,
 39x}: normalize dev pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit modifies the definition of the Device Bus interface pins
to be consistent accross SoCs. Especially, it removes the 'n'
indicators that we don't encode in the subnames of pins:

   'dev(wen0)' becomes 'dev(we0)'
   'dev(wen1)' becomes 'dev(we1)'
   'dev(oen)' becomes 'dev(oe)'
   etc.

In addition, it fixes the Armada 375 DT binding documentation, which
forgot to document the 'dev' function for MPP46, MPP57 and MPP63.

Since only the subnames are changed, this commit does not affect DT
compatibility.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt |  6 +++---
 .../devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt |  8 ++++----
 .../devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt |  6 +++---
 .../devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt | 10 +++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                     |  6 +++---
 drivers/pinctrl/mvebu/pinctrl-armada-375.c                     |  8 ++++----
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c                     |  6 +++---
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c                     | 10 +++++-----
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index e357b02..183c472 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -52,8 +52,8 @@ mpp30         30       gpio, ge0(rxd7), ge1(rxclk), i2c1(sck)
 mpp31         31       gpio, tclk, ge0(txerr)
 mpp32         32       gpio, spi0(cs0)
 mpp33         33       gpio, dev(bootcs), spi0(cs0)
-mpp34         34       gpo, dev(wen0), spi0(mosi)
-mpp35         35       gpo, dev(oen), spi0(sck)
+mpp34         34       gpo, dev(we0), spi0(mosi)
+mpp35         35       gpo, dev(oe), spi0(sck)
 mpp36         36       gpo, dev(a1), spi0(miso)
 mpp37         37       gpo, dev(a0), sata0(prsnt)
 mpp38         38       gpio, dev(ready), uart1(cts), uart0(cts)
@@ -88,7 +88,7 @@ mpp58         58       gpio, dev(cs0), uart1(rts), tdm(int), audio(extclk),
 mpp59         59       gpo, dev(ale0), uart1(rts), uart0(rts), audio(bclk)
 mpp60         60       gpio, dev(ale1), uart1(rxd), sata0(prsnt), pcie(rst-out),
                        audio(sdi)
-mpp61         61       gpo, dev(wen1), uart1(txd), audio(rclk)
+mpp61         61       gpo, dev(we1), uart1(txd), audio(rclk)
 mpp62         62       gpio, dev(a2), uart1(cts), tdm(drx), pcie(clkreq0),
                        audio(mclk), uart0(cts)
 mpp63         63       gpo, spi0(sck), tclk
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
index e22ec5e..ce1771b 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -26,7 +26,7 @@ mpp9          9        gpio, spi0(sck), spi1(sck), nand(we)
 mpp10        10        gpio, dram(vttctrl), led(c1), nand(re)
 mpp11        11        gpio, dev(a0), led(c2), audio(sdo)
 mpp12        12        gpio, dev(a1), audio(bclk)
-mpp13        13        gpio, dev(readyn), pcie0(rstoutn), pcie1(rstoutn)
+mpp13        13        gpio, dev(ready), pcie0(rstoutn), pcie1(rstoutn)
 mpp14        14        gpio, i2c0(sda), uart1(txd)
 mpp15        15        gpio, i2c0(sck), uart1(rxd)
 mpp16        16        gpio, uart0(txd)
@@ -59,7 +59,7 @@ mpp42        42        gpio, spi1(cs2), led(c0)
 mpp43        43        gpio, sata0(prsnt), dram(vttctrl)
 mpp44        44        gpio, sata0(prsnt)
 mpp45        45        gpio, spi0(cs2), pcie0(rstoutn)
-mpp46        46        gpio, led(p0), ge0(txd0), ge1(txd0)
+mpp46        46        gpio, led(p0), ge0(txd0), ge1(txd0), dev(we1)
 mpp47        47        gpio, led(p1), ge0(txd1), ge1(txd1)
 mpp48        48        gpio, led(p2), ge0(txd2), ge1(txd2)
 mpp49        49        gpio, led(p3), ge0(txd3), ge1(txd3)
@@ -70,13 +70,13 @@ mpp53        53        gpio, pcie1(rstoutn), ge0(rxd3), ge1(rxd3)
 mpp54        54        gpio, pcie0(rstoutn), ge0(rxctl), ge1(rxctl)
 mpp55        55        gpio, ge0(rxclk), ge1(rxclk)
 mpp56        56        gpio, ge0(txclkout), ge1(txclkout)
-mpp57        57        gpio, ge0(txctl), ge1(txctl)
+mpp57        57        gpio, ge0(txctl), ge1(txctl), dev(we0)
 mpp58        58        gpio, led(c0)
 mpp59        59        gpio, led(c1)
 mpp60        60        gpio, uart1(txd), led(c2)
 mpp61        61        gpio, i2c1(sda), uart1(rxd), spi1(cs2), led(p0)
 mpp62        62        gpio, i2c1(sck), led(p1)
-mpp63        63        gpio, ptp(trig), led(p2)
+mpp63        63        gpio, ptp(trig), led(p2), dev(burst/last)
 mpp64        64        gpio, dram(vttctrl), led(p3)
 mpp65        65        gpio, sata1(prsnt)
 mpp66        66        gpio, ptp(evreq), spi1(cs3)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 4fb82c1..9844773 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -29,7 +29,7 @@ mpp10         10       gpio, ge0(txd3), dev(ad12)
 mpp11         11       gpio, ge0(txctl), dev(ad13)
 mpp12         12       gpio, ge0(rxd0), pcie0(rstout), spi0(cs1), dev(ad14), pcie3(clkreq)
 mpp13         13       gpio, ge0(rxd1), pcie0(clkreq), pcie1(clkreq) [1], spi0(cs2), dev(ad15), pcie2(clkreq)
-mpp14         14       gpio, ge0(rxd2), ptp(clk), dram(vttctrl), spi0(cs3), dev(wen1), pcie3(clkreq)
+mpp14         14       gpio, ge0(rxd2), ptp(clk), dram(vttctrl), spi0(cs3), dev(we1), pcie3(clkreq)
 mpp15         15       gpio, ge0(rxd3), ge(mdc slave), pcie0(rstout), spi0(mosi)
 mpp16         16       gpio, ge0(rxctl), ge(mdio slave), dram(deccerr), spi0(miso), pcie0(clkreq), pcie1(clkreq) [1]
 mpp17         17       gpio, ge0(rxclk), ptp(clk), ua1(rxd), spi0(sck), sata1(prsnt)
@@ -45,9 +45,9 @@ mpp26         26       gpio, spi0(cs2), i2c1(sck), sd0(d6), dev(cs1)
 mpp27         27       gpio, spi0(cs3), ge1(txclkout), i2c1(sda), sd0(d7), dev(cs2)
 mpp28         28       gpio, ge1(txd0), sd0(clk), dev(ad5)
 mpp29         29       gpio, ge1(txd1), dev(ale0)
-mpp30         30       gpio, ge1(txd2), dev(oen)
+mpp30         30       gpio, ge1(txd2), dev(oe)
 mpp31         31       gpio, ge1(txd3), dev(ale1)
-mpp32         32       gpio, ge1(txctl), dev(wen0)
+mpp32         32       gpio, ge1(txctl), dev(we0)
 mpp33         33       gpio, dram(deccerr), dev(ad3)
 mpp34         34       gpio, dev(ad1)
 mpp35         35       gpio, ref(clk_out1), dev(a1)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index d36cb94..34af69e 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -28,7 +28,7 @@ mpp10	10	gpio, dev(ad12), ptp(evreq)
 mpp11	11	gpio, dev(ad13), led(clk)
 mpp12	12	gpio, pcie0(rstout), dev(ad14), led(stb)
 mpp13	13	gpio, dev(ad15), led(data)
-mpp14	14	gpio, dram(vttctrl), dev(wen1), ua1(txd)
+mpp14	14	gpio, dram(vttctrl), dev(we1), ua1(txd)
 mpp15	15	gpio, pcie0(rstout), spi0(mosi), i2c1(sck)
 mpp16	16	gpio, dram(deccerr), spi0(miso), i2c1(sda)
 mpp17	17	gpio, ua1(rxd), spi0(sck), smi(mdio)
@@ -38,15 +38,15 @@ mpp20	20	gpio, sata0(prsnt) [1], ua0(rts), ua1(txd), smi(mdc)
 mpp21	21	gpio, spi0(cs1), sata0(prsnt) [1], sd0(cmd), dev(bootcs), ge(rxd0)
 mpp22	22	gpio, spi0(mosi), dev(ad0)
 mpp23	23	gpio, spi0(sck), dev(ad2)
-mpp24	24	gpio, spi0(miso), ua0(cts), ua1(rxd), sd0(d4), dev(readyn)
+mpp24	24	gpio, spi0(miso), ua0(cts), ua1(rxd), sd0(d4), dev(ready)
 mpp25	25	gpio, spi0(cs0), ua0(rts), ua1(txd), sd0(d5), dev(cs0)
 mpp26	26	gpio, spi0(cs2), i2c1(sck), sd0(d6), dev(cs1)
 mpp27	27	gpio, spi0(cs3), i2c1(sda), sd0(d7), dev(cs2), ge(txclkout)
 mpp28	28	gpio, sd0(clk), dev(ad5), ge(txd0)
 mpp29	29	gpio, dev(ale0), ge(txd1)
-mpp30	30	gpio, dev(oen), ge(txd2)
+mpp30	30	gpio, dev(oe), ge(txd2)
 mpp31	31	gpio, dev(ale1), ge(txd3)
-mpp32	32	gpio, dev(wen0), ge(txctl)
+mpp32	32	gpio, dev(we0), ge(txctl)
 mpp33	33	gpio, dram(deccerr), dev(ad3)
 mpp34	34	gpio, dev(ad1)
 mpp35	35	gpio, ref(clk), dev(a1)
@@ -55,7 +55,7 @@ mpp37	37	gpio, sd0(d3), dev(ad8), ge(rxclk)
 mpp38	38	gpio, ref(clk), sd0(d0), dev(ad4), ge(rxd1)
 mpp39	39	gpio, i2c1(sck), ua0(cts), sd0(d1), dev(a2), ge(rxd2)
 mpp40	40	gpio, i2c1(sda), ua0(rts), sd0(d2), dev(ad6), ge(rxd3)
-mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burstn), nd(rbn0), ge(rxctl)
+mpp41	41	gpio, ua1(rxd), ua0(cts), spi1(cs3), dev(burst/last), nd(rbn0), ge(rxctl)
 mpp42	42	gpio, ua1(txd), ua0(rts), dev(ad7)
 mpp43	43	gpio, pcie0(clkreq), dram(vttctrl), dram(deccerr), spi1(cs2), dev(clkout), nd(rbn1)
 mpp44	44	gpio, sata0(prsnt) [1], sata1(prsnt) [1], led(clk)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 1eb084c..06d29b5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -207,11 +207,11 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x2, "spi0", "cs0")),
 	MPP_MODE(34,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
-	   MPP_FUNCTION(0x1, "dev", "wen0"),
+	   MPP_FUNCTION(0x1, "dev", "we0"),
 	   MPP_FUNCTION(0x2, "spi0", "mosi")),
 	MPP_MODE(35,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
-	   MPP_FUNCTION(0x1, "dev", "oen"),
+	   MPP_FUNCTION(0x1, "dev", "oe"),
 	   MPP_FUNCTION(0x2, "spi0", "sck")),
 	MPP_MODE(36,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
@@ -352,7 +352,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x5, "audio", "sdi")),
 	MPP_MODE(61,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
-	   MPP_FUNCTION(0x1, "dev", "wen1"),
+	   MPP_FUNCTION(0x1, "dev", "we1"),
 	   MPP_FUNCTION(0x2, "uart1", "txd"),
 	   MPP_FUNCTION(0x5, "audio", "rclk")),
 	MPP_MODE(62,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index ba0913a..6dfe1bf 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -120,7 +120,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x5, "nand", "ale")),
 	MPP_MODE(13,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "dev", "readyn"),
+		 MPP_FUNCTION(0x1, "dev", "ready"),
 		 MPP_FUNCTION(0x2, "pcie0", "rstoutn"),
 		 MPP_FUNCTION(0x3, "pcie1", "rstoutn"),
 		 MPP_FUNCTION(0x5, "nand", "rb"),
@@ -284,7 +284,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x1, "led", "p0"),
 		 MPP_FUNCTION(0x2, "ge0", "txd0"),
 		 MPP_FUNCTION(0x3, "ge1", "txd0"),
-		 MPP_FUNCTION(0x6, "dev", "wen1")),
+		 MPP_FUNCTION(0x6, "dev", "we1")),
 	MPP_MODE(47,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x1, "led", "p1"),
@@ -351,7 +351,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "ge0", "txctl"),
 		 MPP_FUNCTION(0x3, "ge1", "txctl"),
-		 MPP_FUNCTION(0x6, "dev", "wen0")),
+		 MPP_FUNCTION(0x6, "dev", "we0")),
 	MPP_MODE(58,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x4, "led", "c0")),
@@ -379,7 +379,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "ptp", "trig"),
 		 MPP_FUNCTION(0x4, "led", "p2"),
-		 MPP_FUNCTION(0x6, "dev", "burst")),
+		 MPP_FUNCTION(0x6, "dev", "burst/last")),
 	MPP_MODE(64,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "dram", "vttctrl"),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 2b04923..793d0df 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -111,7 +111,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "ptp",   "clk",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "dram",  "vttctrl",    V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",  "cs3",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",   "wen1",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",   "we1",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(6, "pcie3", "clkreq",     V_88F6810_PLUS)),
 	MPP_MODE(15,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
@@ -209,7 +209,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 	MPP_MODE(30,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ge1",   "txd2",       V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",   "oen",        V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dev",   "oe",         V_88F6810_PLUS)),
 	MPP_MODE(31,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ge1",   "txd3",       V_88F6810_PLUS),
@@ -217,7 +217,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 	MPP_MODE(32,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ge1",   "txctl",      V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",   "wen0",       V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dev",   "we0",        V_88F6810_PLUS)),
 	MPP_MODE(33,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "dram",  "deccerr",    V_88F6810_PLUS),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index fa3042a..a5e3627 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -99,7 +99,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(14,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "dram",    "vttctrl",  V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",     "wen1",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",     "we1",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "ua1",     "txd",      V_88F6920_PLUS)),
 	MPP_MODE(15,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -154,7 +154,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "ua0",     "cts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua1",     "rxd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "sd0",     "d4",       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",     "readyn",   V_88F6920_PLUS)),
+		 MPP_VAR_FUNCTION(5, "dev",     "ready",    V_88F6920_PLUS)),
 	MPP_MODE(25,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",    "cs0",      V_88F6920_PLUS),
@@ -186,7 +186,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(8, "ge",      "txd1",     V_88F6920_PLUS)),
 	MPP_MODE(30,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",     "oen",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",     "oe",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "txd2",     V_88F6920_PLUS)),
 	MPP_MODE(31,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -194,7 +194,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(8, "ge",      "txd3",     V_88F6920_PLUS)),
 	MPP_MODE(32,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",     "wen0",     V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",     "we0",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "txctl",    V_88F6920_PLUS)),
 	MPP_MODE(33,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -240,7 +240,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(1, "ua1",     "rxd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua0",     "cts",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi1",    "cs3",      V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(5, "dev",     "burstn",   V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(5, "dev",     "burst/last", V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "nd",      "rbn0",     V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxctl",    V_88F6920_PLUS)),
 	MPP_MODE(42,
-- 
2.1.0
