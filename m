From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:08 +0200
Subject: [PATCH 16/34] pinctrl: mvebu: armada-{370, 375, 38x, 39x,
 xp}: normalize TDM pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit normalizes the naming of the TDM pins accross the
different Marvell SoCs. Mainly it consists in:

 * Removing the 'n' from signal names: 'intn' becomes 'int' and 'rstn'
   becomes 'rst'

 * Renaming the main name 'tdm2c' to 'tdm' on Armada 38x.

 * Change the main name 'tdm-1' to 'tdm' for one of the pins of the
   Armada XP

The last two changes affect DT compatibility, but since the TDM
interface is nowhere near being supported in mainline, it should not
be considered to be a serious problem at this point.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-370-pinctrl.txt          |  2 +-
 .../bindings/pinctrl/marvell,armada-375-pinctrl.txt          |  6 +++---
 .../bindings/pinctrl/marvell,armada-38x-pinctrl.txt          | 12 ++++++------
 .../bindings/pinctrl/marvell,armada-39x-pinctrl.txt          |  4 ++--
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt           |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c                   |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c                   |  6 +++---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c                   | 12 ++++++------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c                   |  4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                    |  2 +-
 10 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
index 183c472..e6dce5d 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
@@ -20,7 +20,7 @@ mpp3          3        gpio, i2c0(sda), uart0(rxd)
 mpp4          4        gpio, cpu_pd(vdd)
 mpp5          5        gpo, ge0(txclko), uart1(txd), spi1(clk), audio(mclk)
 mpp6          6        gpio, ge0(txd0), sata0(prsnt), tdm(rst), audio(sdo)
-mpp7          7        gpo, ge0(txd1), tdm(tdx), audio(lrclk)
+mpp7          7        gpo, ge0(txd1), tdm(dtx), audio(lrclk)
 mpp8          8        gpio, ge0(txd2), uart0(rts), tdm(drx), audio(bclk)
 mpp9          9        gpo, ge0(txd3), uart1(txd), sd0(clk), audio(spdifo)
 mpp10         10       gpio, ge0(txctl), uart0(cts), tdm(fsync), audio(sdi)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
index ce1771b..3140324 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -31,8 +31,8 @@ mpp14        14        gpio, i2c0(sda), uart1(txd)
 mpp15        15        gpio, i2c0(sck), uart1(rxd)
 mpp16        16        gpio, uart0(txd)
 mpp17        17        gpio, uart0(rxd)
-mpp18        18        gpio, tdm(intn)
-mpp19        19        gpio, tdm(rstn)
+mpp18        18        gpio, tdm(int)
+mpp19        19        gpio, tdm(rst)
 mpp20        20        gpio, tdm(pclk)
 mpp21        21        gpio, tdm(fsync)
 mpp22        22        gpio, tdm(drx)
@@ -50,7 +50,7 @@ mpp33        33        gpio, ge1(txd3), spi1(miso)
 mpp34        34        gpio, ge1(txclkout), spi1(sck)
 mpp35        35        gpio, ge1(rxctl), spi1(cs1), spi0(cs2)
 mpp36        36        gpio, pcie0(clkreq)
-mpp37        37        gpio, pcie0(clkreq), tdm(intn), ge(mdc)
+mpp37        37        gpio, pcie0(clkreq), tdm(int), ge(mdc)
 mpp38        38        gpio, pcie1(clkreq), ge(mdio)
 mpp39        39        gpio, ref(clkout)
 mpp40        40        gpio, uart1(txd)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
index 9844773..203220d 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
@@ -63,12 +63,12 @@ mpp44         44       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3
 mpp45         45       gpio, ref(clk_out0), pcie0(rstout)
 mpp46         46       gpio, ref(clk_out1), pcie0(rstout)
 mpp47         47       gpio, sata0(prsnt), sata1(prsnt), sata2(prsnt) [2], sata3(prsnt) [2]
-mpp48         48       gpio, sata0(prsnt), dram(vttctrl), tdm2c(pclk), audio(mclk), sd0(d4), pcie0(clkreq)
-mpp49         49       gpio, sata2(prsnt) [2], sata3(prsnt) [2], tdm2c(fsync), audio(lrclk), sd0(d5), pcie1(clkreq)
-mpp50         50       gpio, pcie0(rstout), tdm2c(drx), audio(extclk), sd0(cmd)
-mpp51         51       gpio, tdm2c(dtx), audio(sdo), dram(deccerr)
-mpp52         52       gpio, pcie0(rstout), tdm2c(intn), audio(sdi), sd0(d6)
-mpp53         53       gpio, sata1(prsnt), sata0(prsnt), tdm2c(rstn), audio(bclk), sd0(d7)
+mpp48         48       gpio, sata0(prsnt), dram(vttctrl), tdm(pclk), audio(mclk), sd0(d4), pcie0(clkreq)
+mpp49         49       gpio, sata2(prsnt) [2], sata3(prsnt) [2], tdm(fsync), audio(lrclk), sd0(d5), pcie1(clkreq)
+mpp50         50       gpio, pcie0(rstout), tdm(drx), audio(extclk), sd0(cmd)
+mpp51         51       gpio, tdm(dtx), audio(sdo), dram(deccerr)
+mpp52         52       gpio, pcie0(rstout), tdm(int), audio(sdi), sd0(d6)
+mpp53         53       gpio, sata1(prsnt), sata0(prsnt), tdm(rst), audio(bclk), sd0(d7)
 mpp54         54       gpio, sata0(prsnt), sata1(prsnt), pcie0(rstout), ge0(txerr), sd0(d3)
 mpp55         55       gpio, ua1(cts), ge(mdio), pcie1(clkreq) [1], spi1(cs1), sd0(d0)
 mpp56         56       gpio, ua1(rts), ge(mdc), dram(deccerr), spi1(mosi)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
index b6bd9cc..1dd76e9 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
@@ -66,8 +66,8 @@ mpp48	48	gpio, sata0(prsnt) [1], dram(vttctrl), tdm(pclk) [1], audio(mclk) [1],
 mpp49	49	gpio, tdm(fsync) [1], audio(lrclk) [1], sd0(d5), ua2(rxd)
 mpp50	50	gpio, pcie0(rstout), tdm(drx) [1], audio(extclk) [1], sd0(cmd), ua2(rxd)
 mpp51	51	gpio, tdm(dtx) [1], audio(sdo) [1], dram(deccerr), ua2(txd)
-mpp52	52	gpio, pcie0(rstout), tdm(intn) [1], audio(sdi) [1], sd0(d6), i2c3(sck)
-mpp53	53	gpio, sata1(prsnt) [1], sata0(prsnt) [1], tdm(rstn) [1], audio(bclk) [1], sd0(d7), i2c3(sda)
+mpp52	52	gpio, pcie0(rstout), tdm(int) [1], audio(sdi) [1], sd0(d6), i2c3(sck)
+mpp53	53	gpio, sata1(prsnt) [1], sata0(prsnt) [1], tdm(rst) [1], audio(bclk) [1], sd0(d7), i2c3(sda)
 mpp54	54	gpio, sata0(prsnt) [1], sata1(prsnt) [1], pcie0(rstout), sd0(d3), ua3(txd)
 mpp55	55	gpio, ua1(cts), spi1(cs1), sd0(d0), ua1(rxd), ua3(rxd)
 mpp56	56	gpio, ua1(rts), dram(deccerr), spi1(mosi), ua1(txd)
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index cefca17..561e519 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -61,7 +61,7 @@ mpp39         39       gpio, spi(cs0)
 mpp40         40       gpio, spi(cs1), uart2(cts), lcd(vga-hsync), pcie(clkreq0)
 mpp41         41       gpio, spi(cs2), uart2(rts), lcd(vga-vsync), sata1(prsnt),
                        pcie(clkreq1)
-mpp42         42       gpio, uart2(rxd), uart0(cts), tdm(int7), tdm-1(timer)
+mpp42         42       gpio, uart2(rxd), uart0(cts), tdm(int7), tdm(timer)
 mpp43         43       gpio, uart2(txd), uart0(rts), spi(cs3), pcie(rstout)
 mpp44         44       gpio, uart2(cts), uart3(rxd), spi(cs4), pcie(clkreq2),
                        dram(bat)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 06d29b5..fe2439c 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -68,7 +68,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	MPP_MODE(7,
 	   MPP_FUNCTION(0x0, "gpo", NULL),
 	   MPP_FUNCTION(0x1, "ge0", "txd1"),
-	   MPP_FUNCTION(0x4, "tdm", "tdx"),
+	   MPP_FUNCTION(0x4, "tdm", "dtx"),
 	   MPP_FUNCTION(0x5, "audio", "lrclk")),
 	MPP_MODE(8,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index 6dfe1bf..c41dd19 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -141,10 +141,10 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x2, "uart0", "rxd")),
 	MPP_MODE(18,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x2, "tdm", "intn")),
+		 MPP_FUNCTION(0x2, "tdm", "int")),
 	MPP_MODE(19,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x2, "tdm", "rstn")),
+		 MPP_FUNCTION(0x2, "tdm", "rst")),
 	MPP_MODE(20,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x2, "tdm", "pclk")),
@@ -242,7 +242,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 	MPP_MODE(37,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
 		 MPP_FUNCTION(0x1, "pcie0", "clkreq"),
-		 MPP_FUNCTION(0x2, "tdm", "intn"),
+		 MPP_FUNCTION(0x2, "tdm", "int"),
 		 MPP_FUNCTION(0x4, "ge", "mdc")),
 	MPP_MODE(38,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 793d0df..b5006f7 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -303,7 +303,7 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata0", "prsnt",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "dram",  "vttctrl",    V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "tdm2c", "pclk",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm",   "pclk",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "mclk",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd0",   "d4",         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(6, "pcie0", "clkreq",     V_88F6810_PLUS)),
@@ -311,32 +311,32 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata2", "prsnt",      V_88F6828),
 		 MPP_VAR_FUNCTION(2, "sata3", "prsnt",      V_88F6828),
-		 MPP_VAR_FUNCTION(3, "tdm2c", "fsync",      V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm",   "fsync",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "lrclk",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd0",   "d5",         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(6, "pcie1", "clkreq",     V_88F6820_PLUS)),
 	MPP_MODE(50,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "tdm2c", "drx",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm",   "drx",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "extclk",     V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd0",   "cmd",        V_88F6810_PLUS)),
 	MPP_MODE(51,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "tdm2c", "dtx",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm",   "dtx",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "sdo",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "dram",  "deccerr",    V_88F6810_PLUS)),
 	MPP_MODE(52,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0", "rstout",     V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "tdm2c", "intn",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm",   "int",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "sdi",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd0",   "d6",         V_88F6810_PLUS)),
 	MPP_MODE(53,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata1", "prsnt",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "sata0", "prsnt",      V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(3, "tdm2c", "rstn",       V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(3, "tdm",   "rst",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "audio", "bclk",       V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(5, "sd0",   "d7",         V_88F6810_PLUS)),
 	MPP_MODE(54,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index de91b35..433291a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -308,7 +308,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 	MPP_MODE(52,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "pcie0",   "rstout",   V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "tdm",     "intn",     V_88F6928),
+		 MPP_VAR_FUNCTION(3, "tdm",     "int",      V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "sdi",      V_88F6928),
 		 MPP_VAR_FUNCTION(5, "sd0",     "d6",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sck",      V_88F6920_PLUS)),
@@ -316,7 +316,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(1, "sata1",   "prsnt",    V_88F6928),
 		 MPP_VAR_FUNCTION(2, "sata0",   "prsnt",    V_88F6928),
-		 MPP_VAR_FUNCTION(3, "tdm",     "rstn",     V_88F6928),
+		 MPP_VAR_FUNCTION(3, "tdm",     "rst",      V_88F6928),
 		 MPP_VAR_FUNCTION(4, "audio",   "bclk",     V_88F6928),
 		 MPP_VAR_FUNCTION(5, "sd0",     "d7",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "i2c3",    "sda",      V_88F6920_PLUS)),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 93b0485..9a8b714 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -252,7 +252,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x1, "uart2", "rxd",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart0", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "tdm", "int7",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "tdm-1", "timer",    V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "tdm", "timer",      V_MV78230_PLUS)),
 	MPP_MODE(43,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart2", "txd",      V_MV78230_PLUS),
-- 
2.1.0
