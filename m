From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  6 Mar 2013 16:29:25 +0100
Subject: [PATCH 3/5] ARM: sunxi: dt: Add uart3 dt node
In-Reply-To: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1362583767-13862-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both A10 and A13 Allwinner SoCs have a Synopsys APB uart3 device
available, so add it to the sunxi.dtsi file

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sunxi.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 4f78ef7..b254ae1 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -68,5 +68,15 @@
 			clocks = <&osc>;
 			status = "disabled";
 		};
+
+		uart3: uart at 01c28c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28c00 0x400>;
+			interrupts = <4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <24000000>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.10.4
