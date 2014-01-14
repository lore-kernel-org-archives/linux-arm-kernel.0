From: s-anna@ti.com (Suman Anna)
Date: Mon, 13 Jan 2014 18:26:47 -0600
Subject: [PATCH 3/3] ARM: dts: AM4372: Add hwspinlock node
In-Reply-To: <1389659207-39445-1-git-send-email-s-anna@ti.com>
References: <1389659207-39445-1-git-send-email-s-anna@ti.com>
Message-ID: <1389659207-39445-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the hwspinlock device tree node for AM43xx family
of SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 974d103..81bf21f 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -325,6 +325,13 @@
 			status = "disabled";
 		};
 
+		hwspinlock: spinlock at 480ca000 {
+			compatible = "ti,omap4-hwspinlock";
+			reg = <0x480ca000 0x1000>;
+			ti,hwmods = "spinlock";
+			#hwlock-cells = <1>;
+		};
+
 		i2c0: i2c at 44e0b000 {
 			compatible = "ti,am4372-i2c","ti,omap4-i2c";
 			reg = <0x44e0b000 0x1000>;
-- 
1.8.4.3
