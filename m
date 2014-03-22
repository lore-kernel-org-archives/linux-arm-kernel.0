From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Mar 2014 13:45:58 +0100
Subject: [PATCH 3/5] ARM: Kirkwood: Fix Atmel vendor prefix
In-Reply-To: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
References: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
Message-ID: <1395492360-1865-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documented vendor prefix for Atmel is 'atmel' not 'at' as used in
these .dts[i] files.

The i2c framework actually ignores the prefix, so making this change
does not cause compatibility issues.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-laplug.dts      | 2 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-laplug.dts b/arch/arm/boot/dts/kirkwood-laplug.dts
index c9e82eff9bf2..6761ffa2c4ab 100644
--- a/arch/arm/boot/dts/kirkwood-laplug.dts
+++ b/arch/arm/boot/dts/kirkwood-laplug.dts
@@ -50,3 +50,3 @@
 			eeprom at 50 {
-				compatible = "at,24c04";
+				compatible = "atmel,24c04";
 				pagesize = <16>;
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 743152f31a81..843eb478b3e4 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -52,3 +52,3 @@
 			eeprom at 50 {
-				compatible = "at,24c04";
+				compatible = "atmel,24c04";
 				pagesize = <16>;
-- 
1.9.1
