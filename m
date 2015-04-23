From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:09:57 -0700
Subject: [PATCH v2 4/9] ARM: dts: BCM63xx: Add SMP nodes and required
 properties
In-Reply-To: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
References: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429830602-10988-5-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update bcm63138.dtsi with the following:

- enable-method for both CPU nodes
- brcm,bcm63138-bootlut node
- resets properties to point to the correct PMB controller to release
  the secondary CPU from reset

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index f5b5c528c26c..bcc0089b0150 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -26,6 +26,7 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0>;
+			enable-method = "brcm,bcm63138";
 		};
 
 		cpu at 1 {
@@ -33,6 +34,8 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <1>;
+			enable-method = "brcm,bcm63138";
+			resets = <&pmb0 4 1>;
 		};
 	};
 
@@ -143,5 +146,10 @@
 			clock-names = "periph";
 			status = "disabled";
 		};
+
+		bootlut: bootlut at 8000 {
+			compatible = "brcm,bcm63138-bootlut";
+			reg = <0x8000 0x50>;
+		};
 	};
 };
-- 
2.1.0
