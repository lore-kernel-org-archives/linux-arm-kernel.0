From: marex@denx.de (Marek Vasut)
Date: Tue, 15 Oct 2013 18:06:37 +0200
Subject: [PATCH 3/6] ARM: dts: imx6qdl: Fix the clock for PCIe
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
Message-ID: <1381853200-5534-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk #205 are lvds_sel, not lvds_gate , so fix this. Moreover,
the PCIe needs lvds_gate for successful operation, so supply these
clock to the PCIe driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 6e1113e..4497f3e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -127,8 +127,8 @@
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <0 123 0x04>;
-			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
-			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
+			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>, <&clks 204>;
+			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_sel", "pcie_axi", "lvds_gate";
 			status = "disabled";
 		};
 
-- 
1.8.4.rc3
