From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 22 Jun 2016 17:27:03 -0700
Subject: [PATCH 3/3] ARM: dts: BCM5301x: Add RNG Device Tree node
In-Reply-To: <1466641623-3491-1-git-send-email-f.fainelli@gmail.com>
References: <1466641623-3491-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1466641623-3491-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT node for the random number generator peripheral.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 7d4d29bf0ed3..c67e451435f4 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -260,6 +260,11 @@
 				     "sata2";
 	};
 
+	rng: rng at 18004000 {
+		compatible = "brcm,bcm5301x-rng";
+		reg = <0x18004000 0x14>;
+	};
+
 	nand: nand at 18028000 {
 		compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1", "brcm,brcmnand";
 		reg = <0x18028000 0x600>, <0x1811a408 0x600>, <0x18028f00 0x20>;
-- 
2.7.4
