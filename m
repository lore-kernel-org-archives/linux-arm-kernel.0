From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 8 Feb 2016 11:59:11 -0600
Subject: [PATCH V2 06/12] dtb: amd: Misc changes for SATA device tree nodes
In-Reply-To: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1454954357-8395-7-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add new SATA1 device node, and fix the register range size of SATA0.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 4be36fd..9f59381 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -66,12 +66,22 @@
 
 		sata0: sata at e0300000 {
 			compatible = "snps,dwc-ahci";
-			reg = <0 0xe0300000 0 0x800>;
+			reg = <0 0xe0300000 0 0xf0000>;
 			interrupts = <0 355 4>;
 			clocks = <&sataclk_333mhz>;
 			dma-coherent;
 		};
 
+		/* This is for Rev B only */
+		sata1: sata at e0d00000 {
+			status = "disabled";
+			compatible = "snps,dwc-ahci";
+			reg = <0 0xe0d00000 0 0xf0000>;
+			interrupts = <0 354 4>;
+			clocks = <&sataclk_333mhz>;
+			dma-coherent;
+		};
+
 		i2c0: i2c at e1000000 {
 			status = "disabled";
 			compatible = "snps,designware-i2c";
-- 
2.5.0
