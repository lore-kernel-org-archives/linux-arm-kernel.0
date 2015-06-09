From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:18 +0200
Subject: [PATCH 26/34] pinctrl: mvebu: armada-xp: add nand rb function
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-27-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version of the Armada XP datasheet documents a new
NAND-related MPP function on MPP48, for which this commit adds
support.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt          | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                              | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index 5f64ee1..bd8af47 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -73,7 +73,7 @@ mpp46         46       gpio, uart3(rts), uart1(rts), spi0(cs6), sata0(prsnt),
                        spi1(cs6)
 mpp47         47       gpio, uart3(cts), uart1(cts), spi0(cs7), pcie(clkreq3),
                        ref(clkout), spi1(cs7)
-mpp48         48       gpio, dev(clkout), dev(burst/last)
+mpp48         48       gpio, dev(clkout), dev(burst/last), nand(rb)
 
 * Marvell Armada XP (mv78260 and mv78460 only)
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 4674462..937d868 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -299,7 +299,8 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "dev", "clkout",     V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x2, "dev", "burst/last", V_MV78230_PLUS)),
+		 MPP_VAR_FUNCTION(0x2, "dev", "burst/last", V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "nand", "rb",        V_MV78230_PLUS)),
 	MPP_MODE(49,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78260_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "dev", "we3",        V_MV78260_PLUS)),
-- 
2.1.0
