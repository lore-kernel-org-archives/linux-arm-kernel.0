From: b20788@freescale.com (Anson Huang)
Date: Wed, 5 Aug 2015 01:48:36 +0800
Subject: [PATCH 2/3] ARM: dts: imx6ul: add mmdc support for i.mx6ul
In-Reply-To: <1438710517-6515-1-git-send-email-b20788@freescale.com>
References: <1438710517-6515-1-git-send-email-b20788@freescale.com>
Message-ID: <1438710517-6515-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MMDC support for i.MX6UL.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 227ba6e..d3c7ae1 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -585,6 +585,11 @@
 				status = "disabled";
 			};
 
+			mmdc: mmdc at 021b0000 {
+				compatible = "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
+				reg = <0x021b0000 0x4000>;
+			};
+
 			qspi: qspi at 021e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.9.1
