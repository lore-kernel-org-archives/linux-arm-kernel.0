From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Dec 2017 15:14:26 -0200
Subject: [PATCH 1/2] ARM: dts: imx6sx-sdb: Disable PCI support
Message-ID: <1513271667-1960-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

When I added PCI support for this board I was testing with mainline U-Boot,
which has PCI support and enables the i.mx6sx PCI power domain.

When running on a U-Boot without PCI support, such as the one provided
by NXP a kernel hang is observed.

Better to disable the pci node for now, until the i.MX6SX PCI power domain
is properly implemented in the kernel.

Reported-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index d57a41c..bb0fe35 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -215,7 +215,8 @@
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_gpio>;
-	status = "okay";
+	/* Keep it disable until mx6sx pci domain is supported */
+	status = "disabled";
 };
 
 &lcdif1 {
-- 
2.7.4
