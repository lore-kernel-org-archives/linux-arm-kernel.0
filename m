From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:02 +0200
Subject: [PATCH 10/34] pinctrl: mvebu: armada-{375, 38x,
 39x}: normalize naming of PTP subnames
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subnames are purely informative, but it's nicer when they match
accross SoCs. This commit adjusts the Armada 375, Armada 38x and
Armada 39x MPP definitions so that the subnames of the PTP pins match
the ones used on Armada XP and Kirkwood.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-375-pinctrl.txt      | 10 +++++-----
 .../bindings/pinctrl/marvell,armada-38x-pinctrl.txt      |  8 ++++----
 .../bindings/pinctrl/marvell,armada-39x-pinctrl.txt      |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c               | 16 ++++++++--------
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c               |  8 ++++----
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c               |  2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
index bedbe42..e22ec5e 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -15,8 +15,8 @@ name          pins     functions
 ================================================================================
 mpp0          0        gpio, dev(ad2), spi0(cs1), spi1(cs1)
 mpp1          1        gpio, dev(ad3), spi0(mosi), spi1(mosi)
-mpp2          2        gpio, dev(ad4), ptp(eventreq), led(c0), audio(sdi)
-mpp3          3        gpio, dev(ad5), ptp(triggen), led(p3), audio(mclk)
+mpp2          2        gpio, dev(ad4), ptp(evreq), led(c0), audio(sdi)
+mpp3          3        gpio, dev(ad5), ptp(trig), led(p3), audio(mclk)
 mpp4          4        gpio, dev(ad6), spi0(miso), spi1(miso)
 mpp5          5        gpio, dev(ad7), spi0(cs2), spi1(cs2)
 mpp6          6        gpio, dev(ad0), led(p1), audio(rclk)
@@ -45,7 +45,7 @@ mpp28        28        gpio, led(p3), ge1(txctl), sd(clk)
 mpp29        29        gpio, pcie1(clkreq), ge1(rxclk), sd(d3)
 mpp30        30        gpio, ge1(txd0), spi1(cs0)
 mpp31        31        gpio, ge1(txd1), spi1(mosi)
-mpp32        32        gpio, ge1(txd2), spi1(sck), ptp(triggen)
+mpp32        32        gpio, ge1(txd2), spi1(sck), ptp(trig)
 mpp33        33        gpio, ge1(txd3), spi1(miso)
 mpp34        34        gpio, ge1(txclkout), spi1(sck)
 mpp35        35        gpio, ge1(rxctl), spi1(cs1), spi0(cs2)
@@ -76,7 +76,7 @@ mpp59        59        gpio, led(c1)
 mpp60        60        gpio, uart1(txd), led(c2)
 mpp61        61        gpio, i2c1(sda), uart1(rxd), spi1(cs2), led(p0)
 mpp62        62        gpio, i2c1(sck), led(p1)
-mpp63        63        gpio, ptp(triggen), led(p2)
+mpp63        63        gpio, ptp(trig), led(p2)
 mpp64        64        gpio, dram(vttctrl), led(p3)
 mpp65        65        gpio, sata1(prsnt)
-mpp66        66        gpio, ptp(eventreq), spi1(cs3)
+mpp66        66        gpio, ptp(evreq), spi1(cs3)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 4ac138a..4fe6340 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -33,8 +33,8 @@ mpp14         14       gpio, ge0(rxd2), ptp(clk), m(vtt_ctrl), spi0(cs3), dev(we
 mpp15         15       gpio, ge0(rxd3), ge(mdc slave), pcie0(rstout), spi0(mosi)
 mpp16         16       gpio, ge0(rxctl), ge(mdio slave), m(decc_err), spi0(miso), pcie0(clkreq), pcie1(clkreq) [1]
 mpp17         17       gpio, ge0(rxclk), ptp(clk), ua1(rxd), spi0(sck), sata1(prsnt)
-mpp18         18       gpio, ge0(rxerr), ptp(trig_gen), ua1(txd), spi0(cs0)
-mpp19         19       gpio, ge0(col), ptp(event_req), ge0(txerr), sata1(prsnt), ua0(cts)
+mpp18         18       gpio, ge0(rxerr), ptp(trig), ua1(txd), spi0(cs0)
+mpp19         19       gpio, ge0(col), ptp(evreq), ge0(txerr), sata1(prsnt), ua0(cts)
 mpp20         20       gpio, ge0(txclk), ptp(clk), sata0(prsnt), ua0(rts)
 mpp21         21       gpio, spi0(cs1), ge1(rxd0), sata0(prsnt), sd0(cmd), dev(bootcs)
 mpp22         22       gpio, spi0(mosi), dev(ad0)
@@ -51,9 +51,9 @@ mpp32         32       gpio, ge1(txctl), dev(wen0)
 mpp33         33       gpio, m(decc_err), dev(ad3)
 mpp34         34       gpio, dev(ad1)
 mpp35         35       gpio, ref(clk_out1), dev(a1)
-mpp36         36       gpio, ptp(trig_gen), dev(a0)
+mpp36         36       gpio, ptp(trig), dev(a0)
 mpp37         37       gpio, ptp(clk), ge1(rxclk), sd0(d3), dev(ad8)
-mpp38         38       gpio, ptp(event_req), ge1(rxd1), ref(clk_out0), sd0(d0), dev(ad4)
+mpp38         38       gpio, ptp(evreq), ge1(rxd1), ref(clk_out0), sd0(d0), dev(ad4)
 mpp39         39       gpio, i2c1(sck), ge1(rxd2), ua0(cts), sd0(d1), dev(a2)
 mpp40         40       gpio, i2c1(sda), ge1(rxd3), ua0(rts), sd0(d2), dev(ad6)
 mpp41         41       gpio, ua1(rxd), ge1(rxctl), ua0(cts), spi1(cs3), dev(burst/last)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index 5b1a9dc..182a059 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -24,7 +24,7 @@ mpp6	6	gpio, dev(cs3), xsmi(mdio)
 mpp7	7	gpio, dev(ad9), xsmi(mdc)
 mpp8	8	gpio, dev(ad10), ptp(trig)
 mpp9	9	gpio, dev(ad11), ptp(clk)
-mpp10	10	gpio, dev(ad12), ptp(event)
+mpp10	10	gpio, dev(ad12), ptp(evreq)
 mpp11	11	gpio, dev(ad13), led(clk)
 mpp12	12	gpio, pcie0(rstout), dev(ad14), led(stb)
 mpp13	13	gpio, dev(ad15), led(data)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index 203291b..ba0913a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -51,7 +51,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 	MPP_MODE(2,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x1, "dev", "ad4"),
-		 MPP_FUNCTION(0x2, "ptp", "eventreq"),
+		 MPP_FUNCTION(0x2, "ptp", "evreq"),
 		 MPP_FUNCTION(0x3, "led", "c0"),
 		 MPP_FUNCTION(0x4, "audio", "sdi"),
 		 MPP_FUNCTION(0x5, "nand", "io4"),
@@ -59,7 +59,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 	MPP_MODE(3,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x1, "dev", "ad5"),
-		 MPP_FUNCTION(0x2, "ptp", "triggen"),
+		 MPP_FUNCTION(0x2, "ptp", "trig"),
 		 MPP_FUNCTION(0x3, "led", "p3"),
 		 MPP_FUNCTION(0x4, "audio", "mclk"),
 		 MPP_FUNCTION(0x5, "nand", "io5"),
@@ -207,7 +207,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x2, "ge1", "txd0"),
 		 MPP_FUNCTION(0x3, "spi1", "cs0"),
 		 MPP_FUNCTION(0x5, "led", "p3"),
-		 MPP_FUNCTION(0x6, "ptp", "eventreq")),
+		 MPP_FUNCTION(0x6, "ptp", "evreq")),
 	MPP_MODE(31,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "ge1", "txd1"),
@@ -217,7 +217,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "ge1", "txd2"),
 		 MPP_FUNCTION(0x3, "spi1", "sck"),
-		 MPP_FUNCTION(0x4, "ptp", "triggen"),
+		 MPP_FUNCTION(0x4, "ptp", "trig"),
 		 MPP_FUNCTION(0x5, "led", "c0")),
 	MPP_MODE(33,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
@@ -290,7 +290,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x1, "led", "p1"),
 		 MPP_FUNCTION(0x2, "ge0", "txd1"),
 		 MPP_FUNCTION(0x3, "ge1", "txd1"),
-		 MPP_FUNCTION(0x5, "ptp", "triggen"),
+		 MPP_FUNCTION(0x5, "ptp", "trig"),
 		 MPP_FUNCTION(0x6, "dev", "ale0")),
 	MPP_MODE(48,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
@@ -309,7 +309,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x1, "led", "c0"),
 		 MPP_FUNCTION(0x2, "ge0", "rxd0"),
 		 MPP_FUNCTION(0x3, "ge1", "rxd0"),
-		 MPP_FUNCTION(0x5, "ptp", "eventreq"),
+		 MPP_FUNCTION(0x5, "ptp", "evreq"),
 		 MPP_FUNCTION(0x6, "dev", "ad12")),
 	MPP_MODE(51,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
@@ -377,7 +377,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x6, "dev", "ad15")),
 	MPP_MODE(63,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x2, "ptp", "triggen"),
+		 MPP_FUNCTION(0x2, "ptp", "trig"),
 		 MPP_FUNCTION(0x4, "led", "p2"),
 		 MPP_FUNCTION(0x6, "dev", "burst")),
 	MPP_MODE(64,
@@ -389,7 +389,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x1, "sata1", "prsnt")),
 	MPP_MODE(66,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x2, "ptp", "eventreq"),
+		 MPP_FUNCTION(0x2, "ptp", "evreq"),
 		 MPP_FUNCTION(0x4, "spi1", "cs3"),
 		 MPP_FUNCTION(0x5, "pcie0", "rstoutn"),
 		 MPP_FUNCTION(0x6, "dev", "cs3")),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index ff411a5..eb4b0d8 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -137,13 +137,13 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 	MPP_MODE(18,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ge0",   "rxerr",      V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(2, "ptp",   "trig_gen",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ptp",   "trig",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "ua1",   "txd",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "spi0",  "cs0",        V_88F6810_PLUS)),
 	MPP_MODE(19,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ge0",   "col",        V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(2, "ptp",   "event_req",  V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(2, "ptp",   "evreq",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "ge0",   "txerr",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "sata1", "prsnt",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "ua0",   "cts",        V_88F6810_PLUS),
@@ -231,7 +231,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(5, "dev",   "a1",         V_88F6810_PLUS)),
 	MPP_MODE(36,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(1, "ptp",   "trig_gen",   V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ptp",   "trig",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",   "a0",         V_88F6810_PLUS)),
 	MPP_MODE(37,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
@@ -241,7 +241,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(5, "dev",   "ad8",        V_88F6810_PLUS)),
 	MPP_MODE(38,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(1, "ptp",   "event_req",  V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(1, "ptp",   "evreq",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ge1",   "rxd1",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "ref",   "clk_out0",   V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "sd0",   "d0",         V_88F6810_PLUS),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 2dcf9b4..4cf7024 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -82,7 +82,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(10,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad12",     V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(7, "ptp",     "event",    V_88F6920_PLUS)),
+		 MPP_VAR_FUNCTION(7, "ptp",     "evreq",    V_88F6920_PLUS)),
 	MPP_MODE(11,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad13",     V_88F6920_PLUS),
-- 
2.1.0
