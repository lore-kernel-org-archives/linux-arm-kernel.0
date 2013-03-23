From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 23 Mar 2013 22:29:54 +0000
Subject: [PATCHv2 1/4] arm: orion5x: fix orion5x.dtsi gpio parameters
In-Reply-To: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
References: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364077797-21206-2-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

orion5x.dtsi is missing the gpio alias as well as including a typo
('ngpio' instead of 'ngpios') that prevented the orion-gpio driver
from loading.  This patches resolves this.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/boot/dts/orion5x.dtsi |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 8aad00f..9bde027 100644
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
@@ -32,7 +35,7 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0x10100 0x40>;
-			ngpio = <32>;
+			ngpios = <32>;
 			interrupts = <6>, <7>, <8>, <9>;
 		};
 
-- 
1.7.10.4
