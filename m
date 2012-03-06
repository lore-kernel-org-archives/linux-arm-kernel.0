From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 6 Mar 2012 10:35:53 -0300
Subject: [PATCH] ARM: mx35: Fix registration of camera clock
Message-ID: <1331040953-15494-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix registration of camera clock so that mx3-camera driver can get its clock
correctly.

Reported-by: Alex Gershgorin <alexg@meprolight.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clock-imx35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 1e279af..e56c1a8 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -483,7 +483,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "max", max_clk)
 	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
-	_REGISTER_CLOCK(NULL, "csi", csi_clk)
+	_REGISTER_CLOCK("mx3-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK(NULL, "iim", iim_clk)
 	_REGISTER_CLOCK(NULL, "gpu2d", gpu2d_clk)
 	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-- 
1.7.1
