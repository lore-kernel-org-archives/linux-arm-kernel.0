From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  2 Jul 2013 20:02:28 +0400
Subject: [PATCH 5/6] ARM: dts: imx27-phytec-phycore-rdk: Add CAN node
In-Reply-To: <1372780949-31897-1-git-send-email-shc_work@mail.ru>
References: <1372780949-31897-1-git-send-email-shc_work@mail.ru>
Message-ID: <1372780949-31897-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CAN (NXP SJA1000) node for Phytec PCM-970 RDK.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index e7ed978..0fc6551 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -35,3 +35,16 @@
 	fsl,uart-has-rtscts;
 	status = "okay";
 };
+
+&weim {
+	can at d4000000 {
+		compatible = "nxp,sja1000";
+		reg = <4 0x00000000 0x00000100>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <19 0x2>;
+		nxp,external-clock-frequency = <16000000>;
+		nxp,tx-output-config = <0x16>;
+		nxp,no-comparator-bypass;
+		fsl,weim-cs-timing = <0x0000dcf6 0x444a0301 0x44443302>;
+	};
+};
-- 
1.8.1.5
