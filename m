From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Dec 2015 19:05:50 +0000
Subject: [PATCH 13/12] ARM: dts: dove: add DT GPU support
In-Reply-To: <1449237604-19064-1-git-send-email-l.stach@pengutronix.de>
References: <1449237604-19064-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <E1a4vfy-000655-2j@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for the Vivante GC600 GPU on Marvell Dove platforms.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This additional patch is in conjunction with my PMU (already merged)
and clock driver patch sets.

 arch/arm/boot/dts/dove.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index ea36a262d056..b1d0eb647ed5 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -773,6 +773,16 @@
 				interrupts = <47>;
 				status = "disabled";
 			};
+
+			gpu: gpu at 840000 {
+				clocks = <&divider_clk 1>;
+				clock-names = "core";
+				compatible = "vivante,gc";
+				interrupts = <48>;
+				power-domains = <&gpu_domain>;
+				reg = <0x840000 0x4000>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.1.0
