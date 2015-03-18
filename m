From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Mar 2015 11:24:02 +0800
Subject: [PATCH 3/3] ARM: sun8i: dt: Enable A23 SMP support
In-Reply-To: <1426649042-30547-1-git-send-email-wens@csie.org>
References: <1426649042-30547-1-git-send-email-wens@csie.org>
Message-ID: <1426649042-30547-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add enable-method property to enable SMP support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 78440dffd678..b5684a0048b2 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -81,6 +81,7 @@
 	};
 
 	cpus {
+		enable-method = "allwinner,sun8i-a23";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -650,6 +651,11 @@
 			};
 		};
 
+		cpucfg at 01f01c00 {
+			compatible = "allwinner,sun8i-a23-cpuconfig";
+			reg = <0x01f01c00 0x300>;
+		};
+
 		r_uart: serial at 01f02800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01f02800 0x400>;
-- 
2.1.4
