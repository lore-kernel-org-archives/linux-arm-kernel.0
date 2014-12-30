From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 13:28:34 -0600
Subject: [PATCH 5/9] dts: versatile: add sysregs nodes
In-Reply-To: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
Message-ID: <1419967718-26909-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The Versatile boards have the same sysregs as other ARM Ltd boards. Add
the nodes in preparation to enable support for 24MHz counter as
sched_clock and MMC card detect and write protect support.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/versatile-ab.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 27d0d9c..62f04b0 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -252,6 +252,29 @@
 			#size-cells = <1>;
 			ranges = <0 0x10000000 0x10000>;
 
+			sysreg at 0 {
+				compatible = "arm,vexpress-sysreg";
+				reg = <0x00000 0x1000>;
+
+				v2m_led_gpios: sys_led at 08 {
+					compatible = "arm,vexpress-sysreg,sys_led";
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+
+				v2m_mmc_gpios: sys_mci at 48 {
+					compatible = "arm,vexpress-sysreg,sys_mci";
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+
+				v2m_flash_gpios: sys_flash at 4c {
+					compatible = "arm,vexpress-sysreg,sys_flash";
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+			};
+
 			aaci at 4000 {
 				compatible = "arm,primecell";
 				reg = <0x4000 0x1000>;
-- 
2.1.0
