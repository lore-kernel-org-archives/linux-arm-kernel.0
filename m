From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:47:16 +0200
Subject: [PATCH 24/34] pinctrl: mvebu: armada-39x: normalize ref clock naming
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-25-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit normalizes the subnames of the reference clock MPP pins in
the Armada 39x pinctrl driver to match with the name used on other
SoCs.

Since only the subnames are changed, DT backward compatibility is not
affected.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 433291a..08ee427 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -205,7 +205,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(5, "dev",     "ad1",      V_88F6920_PLUS)),
 	MPP_MODE(35,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "ref",     "clk",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(1, "ref",     "clk_out1", V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "a1",       V_88F6920_PLUS)),
 	MPP_MODE(36,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
@@ -217,7 +217,7 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(8, "ge",      "rxclk",    V_88F6920_PLUS)),
 	MPP_MODE(38,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(3, "ref",     "clk",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(3, "ref",     "clk_out0", V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(4, "sd0",     "d0",       V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(5, "dev",     "ad4",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(8, "ge",      "rxd1",     V_88F6920_PLUS)),
@@ -263,12 +263,12 @@ static struct mvebu_mpp_mode armada_39x_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(7, "led",     "clk",      V_88F6920_PLUS)),
 	MPP_MODE(45,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "ref",     "clk",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(1, "ref",     "clk_out0", V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(2, "pcie0",   "rstout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "rxd",      V_88F6920_PLUS)),
 	MPP_MODE(46,
 		 MPP_VAR_FUNCTION(0, "gpio",    NULL,       V_88F6920_PLUS),
-		 MPP_VAR_FUNCTION(1, "ref",     "clk",      V_88F6920_PLUS),
+		 MPP_VAR_FUNCTION(1, "ref",     "clk_out1", V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(2, "pcie0",   "rstout",   V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(6, "ua1",     "txd",      V_88F6920_PLUS),
 		 MPP_VAR_FUNCTION(7, "led",     "stb",      V_88F6920_PLUS)),
-- 
2.1.0
