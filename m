From: dev@lynxeye.de (Lucas Stach)
Date: Sat,  8 Apr 2017 16:36:04 +0200
Subject: [RFC PATCH 4/7] ARM: dts: imx6*-hummingboard2: fix PCIe reset polarity
In-Reply-To: <20170408143607.15928-1-dev@lynxeye.de>
References: <20170408143607.15928-1-dev@lynxeye.de>
Message-ID: <20170408143607.15928-5-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver always uses active-low, but better describe reality in the DT.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 126169a..9c4a7d1 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -473,7 +473,7 @@
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hummingboard2_pcie_reset>;
-	reset-gpio = <&gpio2 11 0>;
+	reset-gpio = <&gpio2 11 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.9.3
