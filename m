From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  5 Jun 2016 23:00:47 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Pass the correct PCI reset polarity
Message-ID: <1465178447-24655-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The PCI reset GPIO is active low, so represent it with the
GPIO_ACTIVE_LOW flag.

Even though the imx6 PCI driver will not take the polarity into account
in this case, it is better to provide a correct description in device-tree.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 5248e7b..bea707f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -533,7 +533,7 @@
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio7 12 0>;
+	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
1.9.1
