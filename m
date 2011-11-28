From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Nov 2011 21:37:16 +0800
Subject: [PATCH 2/5] regulator: fix label names used in device tree bindings
In-Reply-To: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1322487439-27254-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree compiler does not recognize '-' in label name.  Instead,
'_' works fine.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 .../devicetree/bindings/regulator/regulator.txt    |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 82bef20..5b7a408 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -32,15 +32,15 @@ its just seen as a special case of a regulator being a
 consumer itself.
 
 Example of a consumer device node (mmc) referencing two
-regulators (twl-reg1 and twl-reg2),
+regulators (twl_reg1 and twl_reg2),
 
-	twl-reg1: regulator at 0 {
+	twl_reg1: regulator at 0 {
 		...
 		...
 		...
 	};
 
-	twl-reg2: regulator at 1 {
+	twl_reg2: regulator at 1 {
 		...
 		...
 		...
@@ -49,6 +49,6 @@ regulators (twl-reg1 and twl-reg2),
 	mmc: mmc at 0x0 {
 		...
 		...
-		vmmc-supply = <&twl-reg1>;
-		vmmcaux-supply = <&twl-reg2>;
+		vmmc-supply = <&twl_reg1>;
+		vmmcaux-supply = <&twl_reg2>;
 	};
-- 
1.7.4.1
