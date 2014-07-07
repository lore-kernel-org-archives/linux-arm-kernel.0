From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  7 Jul 2014 17:19:14 +0200
Subject: [PATCH 4/5] ARM: at91/dt: at91sam9: use ddrck in ramc
In-Reply-To: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404746355-19988-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the ram controller driver take the ddrck clock for at91sam9n12 and
at91sam9x5. For at91sam9g45, use mck instead.

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
