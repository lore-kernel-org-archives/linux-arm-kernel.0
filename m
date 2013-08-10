From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 10 Aug 2013 12:51:51 +0400
Subject: [PATCH 2/2] ARM: dts: imx27-phytec-phycore-som: Enable AUDMUX
In-Reply-To: <1376124711-27167-1-git-send-email-shc_work@mail.ru>
References: <1376124711-27167-1-git-send-email-shc_work@mail.ru>
Message-ID: <1376124711-27167-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds AUDMUX routing for Phytec PCM-038 module.
This route i.MX SSI0 (Port 1) to the slave port 4 where MC13783
codec interface is connected.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index aa70ad7..4ec402c 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -21,6 +21,21 @@
 	};
 };
 
+&audmux {
+	status = "okay";
+
+	/* SSI0 <=> PINS_4 (MC13783 Audio) */
+	ssi0 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <0xcb205000>;
+	};
+
+	pins4 {
+		fsl,audmux-port = <2>;
+		fsl,port-config = <0x00001000>;
+	};
+};
+
 &cspi1 {
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 0>;
-- 
1.8.1.5
