From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 14:27:11 +0100
Subject: [RFC PATCH 4/4] ARM: dts: imx6qdl: Add PU power-domain information to
 gpc node
In-Reply-To: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
References: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392125231-28387-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PGC that is part of GPC controls isolation and power sequencing of the
PU power domain. The power domain will be handled by the generic pm domain
framework and needs a phandle to the PU regulator to turn off power when
the domain is disabled.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 253d82c..595750d 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -598,9 +598,17 @@
 			};
 
 			gpc: gpc at 020dc000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <0 89 0x04 0 90 0x04>;
+				pu-supply = <&reg_pu>;
+
+				pd_pu: power-domain at 020dc260 {
+					compatible = "fsl,power-domain";
+					reg = <0x020dc260 0x10>;
+				};
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
1.8.5.3
