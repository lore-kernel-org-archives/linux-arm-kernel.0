From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 30 Jul 2014 23:29:27 +0200
Subject: [PATCH v3] Documentation: devicetree: Fix tps65090 typos in example
Message-ID: <1406755767-5910-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specification and existing device trees use vsys-l{1,2}-supply,
not vsys_l{1,2}-supply. Fix the example to match the specification.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 21d2202158e9 ("mfd: tps65090: add DT support for tps65090")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Added Fixes header
 * + regulator and mfd maintainers
 
 v1 -> v2:
 * More verbose commit message (requested by Mark Rutland)
 
 Documentation/devicetree/bindings/regulator/tps65090.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/tps65090.txt b/Documentation/devicetree/bindings/regulator/tps65090.txt
index 340980239ea9..ca69f5e3040c 100644
--- a/Documentation/devicetree/bindings/regulator/tps65090.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65090.txt
@@ -45,8 +45,8 @@ Example:
 		infet5-supply = <&some_reg>;
 		infet6-supply = <&some_reg>;
 		infet7-supply = <&some_reg>;
-		vsys_l1-supply = <&some_reg>;
-		vsys_l2-supply = <&some_reg>;
+		vsys-l1-supply = <&some_reg>;
+		vsys-l2-supply = <&some_reg>;
 
 		regulators {
 			dcdc1 {
-- 
1.9.3
