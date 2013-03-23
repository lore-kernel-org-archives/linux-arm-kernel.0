From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 Mar 2013 23:30:11 +0100
Subject: [PATCH 2/5] ARM: sunxi: Add EMAC controller node to sun4i DTSI
In-Reply-To: <1364077814-2233-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364077814-2233-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1364077814-2233-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 03d2b53..a6bd36a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -47,5 +47,12 @@
 				allwinner,pull = <0>;
 			};
 		};
+
+		emac: ethernet at 01c0b000 {
+			compatible = "allwinner,sun4i-emac";
+			reg = <0x01c0b000 0x1000>;
+			interrupts = <55>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.10.4
