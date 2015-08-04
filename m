From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  4 Aug 2015 15:02:22 +0200
Subject: [PATCH 3/3] ARM: imx6: Add clock to OCOTP node
In-Reply-To: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>
References: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1438693342-605-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OCOTP shadow register space is clocked by the ungated ipg root clock,
but to actually sense the fuses, the On-Chip OTP controller needs a
separate clock.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6d1359..07a5d75 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1015,6 +1015,7 @@
 			ocotp: ocotp at 021bc000 {
 				compatible = "fsl,imx6q-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
+				clocks = <&clks IMX6QDL_CLK_IIM>;
 			};
 
 			tzasc at 021d0000 { /* TZASC1 */
-- 
2.1.4
