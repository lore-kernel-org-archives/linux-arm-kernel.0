From: denis@eukrea.com (Denis Carikli)
Date: Fri, 13 Jun 2014 17:21:38 +0200
Subject: [PATCH v2 5/6] ARM: dts: imx25: mbimxsd25: Add touchscreen support.
In-Reply-To: <1402672899-6995-1-git-send-email-denis@eukrea.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
Message-ID: <1402672899-6995-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 9797280..047918d 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -70,3 +70,16 @@
 	lcd-supply = <&reg_lcd_3v3>;
 	status = "okay";
 };
+
+&tscadc {
+	status = "okay";
+
+	tsc: tcq at 50030400 {
+		compatible = "fsl,imx25-tcq";
+		reg = <0x50030400 0x60>;
+		interrupt-parent = <&tscadc>;
+		interrupts = <0>;
+		fsl,wires = <4>;
+		fsl,pen-debounce = <100>;
+	};
+};
-- 
1.7.9.5
