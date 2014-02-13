From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 13 Feb 2014 13:53:59 -0200
Subject: [PATCH 2/2] ARM: dts: imx6qdl-sabresd: Provide min/max voltages for
 codec regulator
In-Reply-To: <1392306839-10736-1-git-send-email-fabio.estevam@freescale.com>
References: <1392306839-10736-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1392306839-10736-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the following message is observed during boot:

wm8962-supply: no parameters

Provide min/max properties for the codec regulator.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a802265..086f770 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -47,6 +47,8 @@
 			compatible = "regulator-fixed";
 			reg = <2>;
 			regulator-name = "wm8962-supply";
+			regulator-min-microvolt = <4200000>;
+			regulator-max-microvolt = <4200000>;
 			gpio = <&gpio4 10 0>;
 			enable-active-high;
 		};
-- 
1.8.1.2
