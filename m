From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 12:01:42 +0900
Subject: [PATCH 2/3] arm64: dts: uniphier: change cpu-release-address
In-Reply-To: <1465873303-30754-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465873303-30754-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465873303-30754-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At first, 256 byte of the head of DRAM space was reserved for some
reasons.  However, as the progress of development, it turned out
unnecessary, and it was never used in the end.  Move the CPU release
address to leave no space.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
index 31dc51b..644025c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
@@ -77,7 +77,7 @@
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0 0x000>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000100>;
+			cpu-release-addr = <0 0x80000000>;
 		};
 
 		cpu1: cpu at 1 {
@@ -85,7 +85,7 @@
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0 0x001>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000100>;
+			cpu-release-addr = <0 0x80000000>;
 		};
 
 		cpu2: cpu at 100 {
@@ -93,7 +93,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x100>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000100>;
+			cpu-release-addr = <0 0x80000000>;
 		};
 
 		cpu3: cpu at 101 {
@@ -101,7 +101,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x101>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000100>;
+			cpu-release-addr = <0 0x80000000>;
 		};
 	};
 
-- 
1.9.1
