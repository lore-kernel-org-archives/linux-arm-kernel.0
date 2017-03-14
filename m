From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 14 Mar 2017 12:14:14 -0700
Subject: [PATCH] dt-bindings: arm-gic: Remove 0x from unit addresses
Message-ID: <20170314191414.29881-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT spec says we shouldn't have '0x' on unit addresses. Remove
them from these examples so people don't copy/pasta them into dts
files.

Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
index 5393e2a45a42..2921655c8909 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
@@ -155,7 +155,7 @@ Example:
 		      <0x0 0xe112f000 0 0x02000>,
 		      <0x0 0xe1140000 0 0x10000>,
 		      <0x0 0xe1160000 0 0x10000>;
-		v2m0: v2m at 0x8000 {
+		v2m0: v2m at 8000 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
 			reg = <0x0 0x80000 0 0x1000>;
@@ -163,7 +163,7 @@ Example:
 
 		....
 
-		v2mN: v2m at 0x9000 {
+		v2mN: v2m at 9000 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
 			reg = <0x0 0x90000 0 0x1000>;
-- 
2.10.0.297.gf6727b0
