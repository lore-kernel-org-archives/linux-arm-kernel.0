From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  8 Jul 2014 18:21:15 +0200
Subject: [PATCHv2 5/6] ARM: at91/dt: at91sam9: use ddrck in ramc
In-Reply-To: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404836476-23787-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the ram controller driver take the ddrck clock for at91sam9n12 and
at91sam9x5.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi | 2 ++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 287795985e32..3d48255c4ed1 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -85,6 +85,8 @@
 			ramc0: ramc at ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
+				clocks = <&ddrck>;
+				clock-names = "ddrck";
 			};
 
 			pmc: pmc at fffffc00 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index d6133f497207..74722853e667 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -93,6 +93,8 @@
 			ramc0: ramc at ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
+				clocks = <&ddrck>;
+				clock-names = "ddrck";
 			};
 
 			pmc: pmc at fffffc00 {
-- 
1.9.1
