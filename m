From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Sat, 1 Feb 2014 14:29:47 +0200
Subject: [PATCH v2] arm: dts: keystone: add watchdog entry
Message-ID: <1391257787-6565-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog entry to keystone device tree.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Conflicts:
	arch/arm/boot/dts/keystone.dtsi
---
Rebased on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

 arch/arm/boot/dts/keystone.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index b420290..3a83ffe 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -208,5 +208,11 @@
 				usb-phy = <&usb_phy>, <&usb_phy>;
 			};
 		};
+
+		wdt: wdt at 022f0080 {
+			compatible = "ti,keystone-wdt","ti,davinci-wdt";
+			reg = <0x022f0080 0x80>;
+			clocks = <&clkwdtimer0>;
+		};
 	};
 };
-- 
1.8.3.2
