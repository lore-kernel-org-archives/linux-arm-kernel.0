From: anilk4.v@gmail.com (Anil Kumar)
Date: Sat, 16 Feb 2013 17:08:27 +0530
Subject: [PATCH 1/2] ARM: dts: omap3: Add gpmc node
In-Reply-To: <1361014708-1659-1-git-send-email-anilk4.v@gmail.com>
References: <1361014708-1659-1-git-send-email-anilk4.v@gmail.com>
Message-ID: <1361014708-1659-2-git-send-email-anilk4.v@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpmc DT node.

Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
---
:100644 100644 1acc261... 9f36531... M	arch/arm/boot/dts/omap3.dtsi
 arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..9f36531 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -397,5 +397,16 @@
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
+
+		gpmc: gpmc at 6e000000 {
+			compatible = "ti,omap3430-gpmc";
+			ti,hwmods = "gpmc";
+			reg = <0x6e000000 0x1000000>;
+			interrupts = <20>;
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <4>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
 	};
 };
-- 
1.7.0.4
