From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:19 +0200
Subject: [PATCH 27/34] pinctrl: mvebu: armada-xp: add dram functions
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-28-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest Armada XP datasheet documents several new DRAM related
functions on various MPPs. This commit adds the description of these
new functions in the Armada XP pinctrl driver and its DT binding
documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt      | 6 +++---
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                          | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index bd8af47..76da722 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -51,8 +51,8 @@ mpp29         29       gpio, lcd(ref-clk), tdm(int0), ptp(clk)
 mpp30         30       gpio, tdm(int1), sd0(clk)
 mpp31         31       gpio, tdm(int2), sd0(cmd)
 mpp32         32       gpio, tdm(int3), sd0(d0)
-mpp33         33       gpio, tdm(int4), sd0(d1), dram(bat)
-mpp34         34       gpio, tdm(int5), sd0(d2), sata0(prsnt)
+mpp33         33       gpio, tdm(int4), sd0(d1), dram(bat), dram(vttctrl)
+mpp34         34       gpio, tdm(int5), sd0(d2), sata0(prsnt), dram(deccerr)
 mpp35         35       gpio, tdm(int6), sd0(d3), sata1(prsnt)
 mpp36         36       gpio, spi0(mosi)
 mpp37         37       gpio, spi0(miso)
@@ -68,7 +68,7 @@ mpp43         43       gpio, uart2(txd), uart0(rts), spi0(cs3), pcie(rstout),
 mpp44         44       gpio, uart2(cts), uart3(rxd), spi0(cs4), pcie(clkreq2),
                        dram(bat), spi1(cs4)
 mpp45         45       gpio, uart2(rts), uart3(txd), spi0(cs5), sata1(prsnt),
-                       spi1(cs5)
+                       spi1(cs5), dram(vttctrl)
 mpp46         46       gpio, uart3(rts), uart1(rts), spi0(cs6), sata0(prsnt),
                        spi1(cs6)
 mpp47         47       gpio, uart3(cts), uart1(cts), spi0(cs7), pcie(clkreq3),
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 937d868..bf70e09 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -215,12 +215,14 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "sd0", "d1",         V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "tdm", "int4",       V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "dram", "bat",       V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dram", "bat",       V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x5, "dram", "vttctrl",   V_MV78230_PLUS)),
 	MPP_MODE(34,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "sd0", "d2",         V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "sata0", "prsnt",    V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "tdm", "int5",       V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x3, "tdm", "int5",       V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dram", "deccerr",   V_MV78230_PLUS)),
 	MPP_MODE(35,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "sd0", "d3",         V_MV78230_PLUS),
@@ -280,6 +282,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x2, "uart3", "txd",      V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "spi0", "cs5",       V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "sata1", "prsnt",    V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x5, "dram", "vttctrl",   V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x6, "spi1", "cs5",       V_MV78230_PLUS)),
 	MPP_MODE(46,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-- 
2.1.0
