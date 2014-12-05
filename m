From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  5 Dec 2014 15:44:57 +0100
Subject: [PATCH 4/5] pinctrl: mvebu: a38x: Add UART1 muxing options
In-Reply-To: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1417790698-9792-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MPP19 and MMP20 pins also have the ability to be muxed to the uart1
function.

Add this case to the pinctrl driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 1049f82fb62f..fd743fab07f5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -145,14 +145,16 @@ static struct mvebu_mpp_mode armada_38x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(2, "ptp",   "event_req",  V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "pcie0", "clkreq",     V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(4, "sata1", "prsnt",      V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "ua0",   "cts",        V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "ua0",   "cts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "rxd",        V_88F6810_PLUS)),
 	MPP_MODE(20,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "ge0",   "txclk",      V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(2, "ptp",   "clk",        V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(3, "pcie1", "rstout",     V_88F6820_PLUS),
 		 MPP_VAR_FUNCTION(4, "sata0", "prsnt",      V_88F6810_PLUS),
-		 MPP_VAR_FUNCTION(5, "ua0",   "rts",        V_88F6810_PLUS)),
+		 MPP_VAR_FUNCTION(5, "ua0",   "rts",        V_88F6810_PLUS),
+		 MPP_VAR_FUNCTION(6, "ua1",   "txd",        V_88F6810_PLUS)),
 	MPP_MODE(21,
 		 MPP_VAR_FUNCTION(0, "gpio",  NULL,         V_88F6810_PLUS),
 		 MPP_VAR_FUNCTION(1, "spi0",  "cs1",        V_88F6810_PLUS),
-- 
2.2.0
