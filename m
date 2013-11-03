From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 Nov 2013 10:30:12 +0100
Subject: [PATCH 1/2] ARM: sun6i: dt: Add IP needed to bring up the additional
 cores
In-Reply-To: <1383471013-21695-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1383471013-21695-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1383471013-21695-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PRCM and CPU configuration units needed for SMP in the A31 DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c1751a64889a..a0646877f5f2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -295,5 +295,15 @@
 			#interrupt-cells = <3>;
 			interrupts = <1 9 0xf04>;
 		};
+
+		cpucfg at 01f01c00 {
+			compatible = "allwinner,sun6i-a31-cpuconfig";
+			reg = <0x01f01c00 0x300>;
+		};
+
+		prcm at 01f01c00 {
+			compatible = "allwinner,sun6i-a31-prcm";
+			reg = <0x01f01400 0x200>;
+		};
 	};
 };
-- 
1.8.4
