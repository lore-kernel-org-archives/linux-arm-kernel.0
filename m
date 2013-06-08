From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  8 Jun 2013 18:39:38 +0400
Subject: [PATCH 3/5] ARM: dts: imx27-phytec-phycore-rdk: Add SDHC support
In-Reply-To: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
References: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370702380-25408-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the SHDC devicetree node for PCM970 board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index f8a7a49..e7ed978 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -19,6 +19,14 @@
 	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
 };
 
+&sdhci2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 29 0>;
+	wp-gpios = <&gpio3 28 0>;
+	vmmc-supply = <&vmmc1_reg>;
+	status = "okay";
+};
+
 &uart1 {
 	fsl,uart-has-rtscts;
 };
-- 
1.8.1.5
