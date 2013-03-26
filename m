From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 26 Mar 2013 21:44:46 +0000
Subject: [PATCHv3 1/4] arm: orion5x: fix orion5x.dtsi gpio parameters
In-Reply-To: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
References: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364334289-19669-2-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

orion5x.dtsi is missing the gpio alias as well as including a typo
('ngpio' instead of 'ngpios') that prevented the orion-gpio driver
from loading.  Also missing were the interrupt-controller properties.
This patches resolves those glitches.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/boot/dts/orion5x.dtsi |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 8aad00f..7c2a326 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -13,6 +13,9 @@
 	compatible = "marvell,orion5x";
 	interrupt-parent = <&intc>;
 
+	aliases {
+		gpio0 = &gpio0;
+	};
 	intc: interrupt-controller {
 		compatible = "marvell,orion-intc", "marvell,intc";
 		interrupt-controller;
@@ -32,7 +35,9 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0x10100 0x40>;
-			ngpio = <32>;
+			ngpios = <32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <6>, <7>, <8>, <9>;
 		};
 
-- 
1.7.10.4
