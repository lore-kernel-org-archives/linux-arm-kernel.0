From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Dec 2015 08:10:43 -0800
Subject: [PATCH 1/3] ARM: dts: Add support for GPMC for dm814x and dra62x
In-Reply-To: <1450800645-10766-1-git-send-email-tony@atomide.com>
References: <1450800645-10766-1-git-send-email-tony@atomide.com>
Message-ID: <1450800645-10766-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for GPMC for dm814x and dra62x

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index a25cd51..3fe68b1 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -548,6 +548,18 @@
 				reg-names = "gmii-sel";
 			};
 		};
+
+		gpmc: gpmc at 50000000 {
+			compatible = "ti,am3352-gpmc";
+			ti,hwmods = "gpmc";
+			ti,no-idle-on-init;
+			reg = <0x50000000 0x2000>;
+			interrupts = <100>;
+			gpmc,num-cs = <7>;
+			gpmc,num-waitpins = <2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
 	};
 };
 
-- 
2.6.2
