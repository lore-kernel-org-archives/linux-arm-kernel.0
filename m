From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:15 +0200
Subject: [PATCH 23/34] pinctrl: mvebu: armada-xp: rename spi to spi0
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-24-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After updating to the latest Armada XP datasheet, we discovered that
there is a second SPI bus accessible from the MPP pins, called 'spi1'.

In order to be consistent with other SoCs having two SPI busses, this
commit renames the functions of the first SPI bus to 'spi0' instead of
just 'spi'.

This commit obviously breaks the DT backward compatibility for the
people using the "spi" function name in their Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt | 22 +++++++++++-----------
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 22 +++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index f2d2d40..e8e0a27 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -54,20 +54,20 @@ mpp32         32       gpio, tdm(int3), sd0(d0)
 mpp33         33       gpio, tdm(int4), sd0(d1), dram(bat)
 mpp34         34       gpio, tdm(int5), sd0(d2), sata0(prsnt)
 mpp35         35       gpio, tdm(int6), sd0(d3), sata1(prsnt)
-mpp36         36       gpio, spi(mosi)
-mpp37         37       gpio, spi(miso)
-mpp38         38       gpio, spi(sck)
-mpp39         39       gpio, spi(cs0)
-mpp40         40       gpio, spi(cs1), uart2(cts), lcd(vga-hsync), pcie(clkreq0)
-mpp41         41       gpio, spi(cs2), uart2(rts), lcd(vga-vsync), sata1(prsnt),
+mpp36         36       gpio, spi0(mosi)
+mpp37         37       gpio, spi0(miso)
+mpp38         38       gpio, spi0(sck)
+mpp39         39       gpio, spi0(cs0)
+mpp40         40       gpio, spi0(cs1), uart2(cts), lcd(vga-hsync), pcie(clkreq0)
+mpp41         41       gpio, spi0(cs2), uart2(rts), lcd(vga-vsync), sata1(prsnt),
                        pcie(clkreq1)
 mpp42         42       gpio, uart2(rxd), uart0(cts), tdm(int7), tdm(timer)
-mpp43         43       gpio, uart2(txd), uart0(rts), spi(cs3), pcie(rstout)
-mpp44         44       gpio, uart2(cts), uart3(rxd), spi(cs4), pcie(clkreq2),
+mpp43         43       gpio, uart2(txd), uart0(rts), spi0(cs3), pcie(rstout)
+mpp44         44       gpio, uart2(cts), uart3(rxd), spi0(cs4), pcie(clkreq2),
                        dram(bat)
-mpp45         45       gpio, uart2(rts), uart3(txd), spi(cs5), sata1(prsnt)
-mpp46         46       gpio, uart3(rts), uart1(rts), spi(cs6), sata0(prsnt)
-mpp47         47       gpio, uart3(cts), uart1(cts), spi(cs7), pcie(clkreq3),
+mpp45         45       gpio, uart2(rts), uart3(txd), spi0(cs5), sata1(prsnt)
+mpp46         46       gpio, uart3(rts), uart1(rts), spi0(cs6), sata0(prsnt)
+mpp47         47       gpio, uart3(cts), uart1(cts), spi0(cs7), pcie(clkreq3),
                        ref(clkout)
 mpp48         48       gpio, dev(clkout), dev(burst/last)
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index fb5ffa5..74ff211 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -224,25 +224,25 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x3, "tdm", "int6",       V_MV78230_PLUS)),
 	MPP_MODE(36,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "spi", "mosi",       V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x1, "spi0", "mosi",      V_MV78230_PLUS)),
 	MPP_MODE(37,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "spi", "miso",       V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x1, "spi0", "miso",      V_MV78230_PLUS)),
 	MPP_MODE(38,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "spi", "sck",        V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x1, "spi0", "sck",       V_MV78230_PLUS)),
 	MPP_MODE(39,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "spi", "cs0",        V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x1, "spi0", "cs0",       V_MV78230_PLUS)),
 	MPP_MODE(40,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "spi", "cs1",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "spi0", "cs1",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart2", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "vga-hsync",  V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq0",   V_MV78230_PLUS)),
 	MPP_MODE(41,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "spi", "cs2",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "spi0", "cs2",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart2", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "sata1", "prsnt",    V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "lcd", "vga-vsync",  V_MV78230_PLUS),
@@ -257,32 +257,32 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart2", "txd",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart0", "rts",      V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "spi", "cs3",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi0", "cs3",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "pcie", "rstout",    V_MV78230_PLUS)),
 	MPP_MODE(44,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart2", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart3", "rxd",      V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "spi", "cs4",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi0", "cs4",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "dram", "bat",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq2",   V_MV78230_PLUS)),
 	MPP_MODE(45,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart2", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart3", "txd",      V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "spi", "cs5",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi0", "cs5",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "sata1", "prsnt",    V_MV78230_PLUS)),
 	MPP_MODE(46,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart3", "rts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart1", "rts",      V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "spi", "cs6",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi0", "cs6",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "sata0", "prsnt",    V_MV78230_PLUS)),
 	MPP_MODE(47,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "uart3", "cts",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "uart1", "cts",      V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "spi", "cs7",        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "spi0", "cs7",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "ref", "clkout",     V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq3",   V_MV78230_PLUS)),
 	MPP_MODE(48,
-- 
2.1.0
