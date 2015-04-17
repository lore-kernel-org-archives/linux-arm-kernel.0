From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 17 Apr 2015 15:33:47 -0700
Subject: [PATCH 2/7] ARM: dts: BCM63xx: Add PMB busses nodes
In-Reply-To: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
References: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429310032-19402-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the two BCM63138 PMB busses nodes found on this System-on-a-Chip as
described in their corresponding binding document.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index f46329c8ad75..f5b5c528c26c 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -105,6 +105,18 @@
 			reg = <0x1e620 0x20>;
 			interrupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pmb0: reset-controller at 4800c0 {
+			compatible = "brcm,bcm63138-pmb";
+			reg = <0x4800c0 0x10>;
+			#reset-cells = <2>;
+		};
+
+		pmb1: reset-controller at 4800e0 {
+			compatible = "brcm,bcm63138-pmb";
+			reg = <0x4800e0 0x10>;
+			#reset-cells = <2>;
+		};
 	};
 
 	/* Legacy UBUS base */
-- 
2.1.0
