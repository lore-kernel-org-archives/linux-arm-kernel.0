From: stefan@agner.ch (Stefan Agner)
Date: Mon,  4 Apr 2016 22:28:41 -0700
Subject: [PATCH v3 9/9] ARM: dts: ls1021a: add pix clock to DCU dts node
In-Reply-To: <1459834121-25997-1-git-send-email-stefan@agner.ch>
References: <1459834121-25997-1-git-send-email-stefan@agner.ch>
Message-ID: <1459834121-25997-10-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DCU IP has distinct clock inputs for register access and the
pixel clocks, at least in some implementations. LS1021a seems to
use the same clock, therefore specify the same clock for "dcu"
and "pix".

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/ls1021a.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 2c84ca2..cd5c76d 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -443,8 +443,9 @@
 			compatible = "fsl,ls1021a-dcu";
 			reg = <0x0 0x2ce0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&platform_clk 0>;
-			clock-names = "dcu";
+			clocks = <&platform_clk 0>,
+				<&platform_clk 0>;
+			clock-names = "dcu", "pix";
 			big-endian;
 			status = "disabled";
 		};
-- 
2.7.4
