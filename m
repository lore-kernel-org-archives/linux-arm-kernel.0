From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Mar 2013 21:50:01 +0100
Subject: [PATCH 2/5] ARM: sunxi: Add wemac to sun4i dtsi
In-Reply-To: <1363380605-6577-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1363380605-6577-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1363380605-6577-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 03d2b53..f3c2158 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -47,5 +47,12 @@
 				allwinner,pull = <0>;
 			};
 		};
+
+		wemac: ethernet at 01c0b000 {
+			compatible = "davicom,wemac";
+			reg = <0x01c0b000 0x1000>;
+			interrupts = <55>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.10.4
