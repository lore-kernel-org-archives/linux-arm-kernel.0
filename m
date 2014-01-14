From: s-anna@ti.com (Suman Anna)
Date: Mon, 13 Jan 2014 18:26:46 -0600
Subject: [PATCH 2/3] ARM: dts: DRA7: Add hwspinlock node
In-Reply-To: <1389659207-39445-1-git-send-email-s-anna@ti.com>
References: <1389659207-39445-1-git-send-email-s-anna@ti.com>
Message-ID: <1389659207-39445-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the hwspinlock device tree node for DRA7 SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..672ffec 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -425,6 +425,13 @@
 			ti,hwmods = "wd_timer2";
 		};
 
+		hwspinlock: spinlock at 4a0f6000 {
+			compatible = "ti,omap4-hwspinlock";
+			reg = <0x4a0f6000 0x1000>;
+			ti,hwmods = "spinlock";
+			#hwlock-cells = <1>;
+		};
+
 		i2c1: i2c at 48070000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48070000 0x100>;
-- 
1.8.4.3
