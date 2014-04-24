From: anders.berg@lsi.com (Anders Berg)
Date: Thu, 24 Apr 2014 12:44:09 +0200
Subject: [PATCH v2 6/6] ARM: dts: axxia: Add reset controller
In-Reply-To: <cover.1398335771.git.anders.berg@lsi.com>
References: <cover.1398335771.git.anders.berg@lsi.com>
Message-ID: <a90c7c7bb7a922e71bd1ca503306ef2fdf81485e.1398335771.git.anders.berg@lsi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the reset controller to the AXM5xx device tree.

Signed-off-by: Anders Berg <anders.berg@lsi.com>
---
 arch/arm/boot/dts/axm55xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index 5d63887..bd1e07d 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -208,6 +208,11 @@
 			reg = <0x20 0x10030000 0 0x2000>;
 		};
 
+		reset: reset at 2010031000 {
+			compatible = "lsi,axm55xx-reset";
+			syscon = <&syscon>;
+		};
+
 		amba {
 			compatible = "arm,amba-bus";
 			#address-cells = <2>;
-- 
1.8.3.2
