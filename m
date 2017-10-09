From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  9 Oct 2017 11:43:44 -0700
Subject: [PATCH] ARM: dts: imx7d: Invert legacy PCI irq mapping
Message-ID: <20171009184344.5839-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to i.MX7D reference manual (Rev. 0.1, table 7-1, page 1221)
legacy PCI interrupt mapping is as follows:

 - PCIE INT A is IRQ 122
 - PCIE INT B is IRQ 123
 - PCIE INT C is IRQ 124
 - PCIE INT D is IRQ 125

Invert the mapping information in corresponding DT node to reflect
that.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: yurovsky at gmail.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Discovered by using custom build of QEMU[1] when using together with
"usb-ehci" which is, AFAIU, ICH4. A bit of a convoluted use-case, but
I thought it would still be worht fixing.

[1] https://github.com/ndreys/qemu/tree/imx7-support-upstreaming 

 arch/arm/boot/dts/imx7d.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index f46814a7ea44..4d308d17f040 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -144,10 +144,10 @@
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 2 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 3 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 4 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clks IMX7D_PCIE_CTRL_ROOT_CLK>,
 			 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>,
 			 <&clks IMX7D_PCIE_PHY_ROOT_CLK>;
-- 
2.13.5
