From: anders.berg@lsi.com (Anders Berg)
Date: Tue, 15 Apr 2014 14:06:14 +0200
Subject: [PATCH 5/5] ARM: dts: axxia: Add reset controller
In-Reply-To: <cover.1397552154.git.anders.berg@lsi.com>
References: <cover.1397552154.git.anders.berg@lsi.com>
Message-ID: <b61990ec230e1a4f922689aff46c9d6e1578be3a.1397552154.git.anders.berg@lsi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the reset controller to the AXM5xx device tree.

Signed-off-by: Anders Berg <anders.berg@lsi.com>
---
 arch/arm/boot/dts/axm55xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index 25fc174..9e33a8e 100644
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
