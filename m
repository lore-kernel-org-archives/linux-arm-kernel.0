From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Thu, 9 Feb 2017 14:29:15 +0800
Subject: [PATCH 2/2] arm64: dts: added ecc register address to sata node on
 ls1046a
In-Reply-To: <1486621755-6567-1-git-send-email-yuantian.tang@nxp.com>
References: <1486621755-6567-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <1486621755-6567-2-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

For ls1046 sata, ecc should be disabled due to a erratum.
Provide the ecc register address for driver to use.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 38806ca..ee19d74 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -507,7 +507,9 @@
 
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1046a-ahci";
-			reg = <0x0 0x3200000 0x0 0x10000>;
+			reg = <0x0 0x3200000 0x0 0x10000>,
+				<0x0 0x20140520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
 		};
-- 
2.1.0.27.g96db324
