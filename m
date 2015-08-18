From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:09:01 +0200
Subject: [PATCH 10/10] ARM: marvell: modify Orion and Kirkwoord crypto
 compatible strings
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicitly use the SoC specific compatible strings in kirkwood.dtsi and
dove.dtsi, so that the crypto devices have access to the TDMA feature
when attached to the new CESA driver.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/dove.dtsi     | 2 +-
 arch/arm/boot/dts/kirkwood.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 9bb3131..cd58c2e 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -263,7 +263,7 @@
 			};
 
 			crypto: crypto-engine at 30000 {
-				compatible = "marvell,orion-crypto";
+				compatible = "marvell,dove-crypto";
 				reg = <0x30000 0x10000>;
 				reg-names = "regs";
 				interrupts = <31>;
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index c5f913b..7b5a4a1 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -251,7 +251,7 @@
 		};
 
 		cesa: crypto at 30000 {
-			compatible = "marvell,orion-crypto";
+			compatible = "marvell,kirkwood-crypto";
 			reg = <0x30000 0x10000>;
 			reg-names = "regs";
 			interrupts = <22>;
-- 
1.9.1
