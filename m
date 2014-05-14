From: anders.berg@avagotech.com (Anders Berg)
Date: Wed, 14 May 2014 20:38:01 +0200
Subject: [PATCH v3 6/6] ARM: dts: axxia: Add reset controller
In-Reply-To: <cover.1400072260.git.anders.berg@avagotech.com>
References: <cover.1400072260.git.anders.berg@avagotech.com>
Message-ID: <b4860db76b5af89cef4246ce73a00293b7fe912b.1400072260.git.anders.berg@avagotech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anders Berg <anders.berg@lsi.com>

Add the reset controller to the AXM5xx device tree.

Signed-off-by: Anders Berg <anders.berg@lsi.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
