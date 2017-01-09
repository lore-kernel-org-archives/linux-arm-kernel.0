From: s-anna@ti.com (Suman Anna)
Date: Mon, 9 Jan 2017 13:43:55 -0600
Subject: [PATCH 2/5] ARM: dts: keystone: Add PSC node
In-Reply-To: <20170109194358.27271-1-s-anna@ti.com>
References: <20170109194358.27271-1-s-anna@ti.com>
Message-ID: <20170109194358.27271-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power Sleep Controller (PSC) module is responsible
for the power and clock management for each of the peripherals
present on the SoC. Represent this as a syscon node so that
multiple users can leverage it for various functionalities.

Signed-off-by: Suman Anna <s-anna@ti.com>
[afd at ti.com: add simple-mfd compatible]
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 02708ba2d4f4..ec203d0a673d 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -83,6 +83,11 @@
 			reg = <0x02310000 0x200>;
 		};
 
+		psc: power-sleep-controller at 02350000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x02350000 0x1000>;
+		};
+
 		devctrl: device-state-control at 02620000 {
 			compatible = "ti,keystone-devctrl", "syscon";
 			reg = <0x02620000 0x1000>;
-- 
2.10.2
