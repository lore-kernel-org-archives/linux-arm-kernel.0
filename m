From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:46:55 +0200
Subject: [PATCH 03/34] pinctrl: mvebu: armada-375: remove non-existing NAND
 re/we pins
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After updating to a more recent version of the Armada 375, we realized
that some of the pins documented as having a NAND-related
functionality in fact did not have such functionality. This commit
updates the pinctrl driver accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.15+
Fixes: ce3ed59dcddd ("pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 375")
---
 .../devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt        | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-375.c                            | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
index 7de0cda..bedbe42 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
@@ -22,8 +22,8 @@ mpp5          5        gpio, dev(ad7), spi0(cs2), spi1(cs2)
 mpp6          6        gpio, dev(ad0), led(p1), audio(rclk)
 mpp7          7        gpio, dev(ad1), ptp(clk), led(p2), audio(extclk)
 mpp8          8        gpio, dev (bootcs), spi0(cs0), spi1(cs0)
-mpp9          9        gpio, nf(wen), spi0(sck), spi1(sck)
-mpp10        10        gpio, nf(ren), dram(vttctrl), led(c1)
+mpp9          9        gpio, spi0(sck), spi1(sck), nand(we)
+mpp10        10        gpio, dram(vttctrl), led(c1), nand(re)
 mpp11        11        gpio, dev(a0), led(c2), audio(sdo)
 mpp12        12        gpio, dev(a1), audio(bclk)
 mpp13        13        gpio, dev(readyn), pcie0(rstoutn), pcie1(rstoutn)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index ca1e757..e740a42 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -98,13 +98,11 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x5, "nand", "ce")),
 	MPP_MODE(9,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "nf", "wen"),
 		 MPP_FUNCTION(0x2, "spi0", "sck"),
 		 MPP_FUNCTION(0x3, "spi1", "sck"),
 		 MPP_FUNCTION(0x5, "nand", "we")),
 	MPP_MODE(10,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "nf", "ren"),
 		 MPP_FUNCTION(0x2, "dram", "vttctrl"),
 		 MPP_FUNCTION(0x3, "led", "c1"),
 		 MPP_FUNCTION(0x5, "nand", "re"),
-- 
2.1.0
