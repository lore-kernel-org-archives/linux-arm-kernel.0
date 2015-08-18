From: aalonso@freescale.com (Adrian Alonso)
Date: Tue, 18 Aug 2015 10:48:53 -0500
Subject: [PATCH 2/8] ARM: dts: imx: imx7d add iomuxc lpsr device node
In-Reply-To: <1439912939-17535-1-git-send-email-aalonso@freescale.com>
References: <1439912939-17535-1-git-send-email-aalonso@freescale.com>
Message-ID: <1439912939-17535-2-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node to support iomuxc-lpsr controller

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b738ce0..00f70db 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -446,6 +446,11 @@
 				status = "disabled";
 			};
 
+			iomuxc_lpsr: iomuxc-lpsr at 302c0000 {
+				compatible = "fsl,imx7d-iomuxc-lpsr";
+				reg = <0x302c0000 0x10000>;
+			};
+
 			gpt1: gpt at 302d0000 {
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302d0000 0x10000>;
-- 
2.1.4
