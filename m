From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 13 Oct 2015 02:54:02 +0300
Subject: [PATCH 2/5] arm: dts: lpc32xx: fix improper usage of ranges property
In-Reply-To: <1444694045-22000-1-git-send-email-vz@mleia.com>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
Message-ID: <1444694045-22000-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change corrects invalid custom translations to 1:1 translations,
otherwise during initialization there are too many failed attempts to
translate addresses from subnodes, which anyway result in fallback 1:1
translations, also it is found that due to this problem proper usage
of ranges property in subnodes (e.g. for defining flash partitions)
can not be done.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index f35e982..3ef804c 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -31,7 +31,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		ranges = <0x20000000 0x20000000 0x30000000>;
+		ranges;
 
 		/*
 		 * Enable either SLC or MLC
@@ -89,7 +89,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-			ranges = <0x20000000 0x20000000 0x30000000>;
+			ranges;
 
 			ssp0: ssp at 20084000 {
 				compatible = "arm,pl022", "arm,primecell";
@@ -207,7 +207,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-			ranges = <0x20000000 0x20000000 0x30000000>;
+			ranges;
 
 			/*
 			 * MIC Interrupt controller includes:
-- 
2.1.4
