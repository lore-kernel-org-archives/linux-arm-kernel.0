From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  5 Oct 2012 16:31:45 +0100
Subject: [PATCH 09/10] ARM: ux500: Apply a Device Tree node for the STMPE MFD
In-Reply-To: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
References: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349451107-8009-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we apply the STMPE Multi-Functional Device's node to the
ST User Interface Board Device Tree file. It includes all of
the properties required for correct device initialsation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stuib.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
index 62f3ecd..b25663c 100644
--- a/arch/arm/boot/dts/stuib.dtsi
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -11,6 +11,19 @@
 
 / {
 	soc-u9500 {
+		i2c at 80004000 {
+			stmpe1601: stmpe1601 at 40 {
+				compatible = "st,stmpe1601";
+				reg = <0x40>;
+				interrupts = <26 0x4>;
+				interrupt-parent = <&gpio6>;
+				interrupt-controller;
+
+				i2c-client-wake;
+				st,autosleep-timeout = <1024>;
+			};
+		};
+
 		i2c at 80110000 {
 			bu21013_tp at 0x5c {
 				compatible = "rhom,bu21013_tp";
-- 
1.7.9.5
