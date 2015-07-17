From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Fri, 17 Jul 2015 18:39:03 +0800
Subject: [PATCH v10 5/5] arm/dts/ls1021a: Add a TFT LCD panel dts node
In-Reply-To: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
References: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <1437129543-8037-5-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianwei Wang <jianwei.wang.chn@gmail.com>

Add a  TFT LCD panel. the TFT LCD panel is WQVGA "480x272",
and the bpp is 24.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
Reviewed-by: Alison Wang <alison.wang@freescale.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a2c591e..2443329 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -56,6 +56,17 @@
 		enet0_sgmii_phy = &sgmii_phy2;
 		enet1_sgmii_phy = &sgmii_phy0;
 	};
+
+	panel: panel {
+		compatible = "nec,nl4827hc19_05b";
+	};
+
+};
+
+&dcu {
+	fsl,panel = <&panel>;
+	status = "okay";
+
 };
 
 &dspi1 {
-- 
2.1.0.27.g96db324
