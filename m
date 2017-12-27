From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 12:04:37 -0200
Subject: [PATCH 4/5] ARM: dts: imx28-apx4devkit: Pass unit address and reg to
 IOMUX node
In-Reply-To: <1514383478-32544-1-git-send-email-festevam@gmail.com>
References: <1514383478-32544-1-git-send-email-festevam@gmail.com>
Message-ID: <1514383478-32544-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass unit address and reg to IOMUX node to fix the following build
warning with W=1:

arch/arm/boot/dts/imx28-apx4devkit.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc2-sck-cfg-apx4 missing or empty reg/ranges property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index ae07834..91456bc 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -82,7 +82,8 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc2_sck_cfg_apx4: mmc2-sck-cfg-apx4 {
+				mmc2_sck_cfg_apx4: mmc2-sck-cfg-apx4 at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA7__SSP2_SCK
 					>;
-- 
2.7.4
