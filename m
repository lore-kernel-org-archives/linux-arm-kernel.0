From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 28 Feb 2014 17:03:45 +0100
Subject: [PATCH v5 3/5] ARM: dts: imx6qdl: Add power-domain information to gpc
 node
In-Reply-To: <1393603427-6199-1-git-send-email-p.zabel@pengutronix.de>
References: <1393603427-6199-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1393603427-6199-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PGC that is part of GPC controls isolation and power sequencing of the
power domains. The PU power domain will be handled by the generic pm domain
framework. It needs a phandle to the PU regulator to turn off power when
the domain is disabled, and a list of phandles to all clocks that must be
enabled during powerup for reset propagation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v4:
 - Use OF power domain bindings
 - Added reset clocks
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2e..00f0bf0 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -600,6 +600,10 @@
 				compatible = "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <0 89 0x04 0 90 0x04>;
+				pu-supply = <&reg_pu>;
+				clocks = <&clks 122>, <&clks 74>, <&clks 121>,
+					 <&clks 26>, <&clks 143>, <&clks 168>;
+				#power-domain-cells = <1>;
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
1.8.5.3
