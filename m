From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:53 -0600
Subject: [PATCH 05/13] dtb: amd: Misc changes for I2C device nodes
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-6-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add new i2c1 device node, and fix the incorrect clock frequency.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index c7c759a..4be36fd 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -77,7 +77,15 @@
 			compatible = "snps,designware-i2c";
 			reg = <0 0xe1000000 0 0x1000>;
 			interrupts = <0 357 4>;
-			clocks = <&uartspiclk_100mhz>;
+			clocks = <&miscclk_250mhz>;
+		};
+
+		i2c1: i2c at e0050000 {
+			status = "disabled";
+			compatible = "snps,designware-i2c";
+			reg = <0 0xe0050000 0 0x1000>;
+			interrupts = <0 340 4>;
+			clocks = <&miscclk_250mhz>;
 		};
 
 		serial0: serial at e1010000 {
-- 
2.5.0
