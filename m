From: aalonso@freescale.com (Adrian Alonso)
Date: Thu, 10 Sep 2015 14:21:43 -0500
Subject: [PATCH v3 3/8] ARM: dts: imx: imx7d add iomuxc lpsr device node
In-Reply-To: <1441912908-21946-1-git-send-email-aalonso@freescale.com>
References: <1441912908-21946-1-git-send-email-aalonso@freescale.com>
Message-ID: <1441912908-21946-3-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node to support iomuxc-lpsr controller, iput-sel phandle
allows to get input select register base address which is shared from
iomuxc controller.

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V2: Resend
Changes for V3: Add phandle to get input select register base address

 arch/arm/boot/dts/imx7d.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b738ce0..9d997e0 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -446,6 +446,12 @@
 				status = "disabled";
 			};
 
+			iomuxc_lpsr: iomuxc-lpsr at 302c0000 {
+				compatible = "fsl,imx7d-iomuxc-lpsr";
+				reg = <0x302c0000 0x10000>;
+				input-sel = <&iomuxc>;
+			};
+
 			gpt1: gpt at 302d0000 {
 				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
 				reg = <0x302d0000 0x10000>;
-- 
2.1.4
