From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:46:58 +0200
Subject: [PATCH 06/34] pinctrl: mvebu: armada-xp: fix functions of MPP48
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was a mistake in the definition of the functions for MPP48 on
Marvell Armada XP. The second function is dev(clkout), and not tclk.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.7+
Fixes: 463e270f766a ("pinctrl: mvebu: add pinctrl driver for Armada XP")
---
 Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c                               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
index b347b85..96e7744 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
@@ -69,7 +69,7 @@ mpp45         45       gpio, uart2(rts), uart3(txd), spi(cs5), sata1(prsnt)
 mpp46         46       gpio, uart3(rts), uart1(rts), spi(cs6), sata0(prsnt)
 mpp47         47       gpio, uart3(cts), uart1(cts), spi(cs7), pcie(clkreq3),
                        ref(clkout)
-mpp48         48       gpio, tclk, dev(burst/last)
+mpp48         48       gpio, dev(clkout), dev(burst/last)
 
 * Marvell Armada XP (mv78260 and mv78460 only)
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 0301bd2..d7cdb14 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -287,7 +287,7 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x5, "pcie", "clkreq3",   V_MV78230_PLUS)),
 	MPP_MODE(48,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78230_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "tclk", NULL,        V_MV78230_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "clkout",     V_MV78230_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "dev", "burst/last", V_MV78230_PLUS)),
 	MPP_MODE(49,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_MV78260_PLUS),
-- 
2.1.0
