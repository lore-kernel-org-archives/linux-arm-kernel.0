From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Mar 2013 11:35:14 +0100
Subject: [PATCH 5/7] ARM: sunxi: dt: Add uart3 dt node
In-Reply-To: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1363689316-7847-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both A10 and A13 Allwinner SoCs have a Synopsys APB uart3 device
available, so add it to the sunxi.dtsi file

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sunxi.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index cf53c43..a85030b 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -68,5 +68,15 @@
 			clocks = <&osc>;
 			status = "disabled";
 		};
+
+		uart3: serial at 01c28c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28c00 0x400>;
+			interrupts = <4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&osc>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.10.4
