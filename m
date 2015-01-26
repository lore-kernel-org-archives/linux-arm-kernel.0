From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 26 Jan 2015 09:22:18 -0700
Subject: [PATCH 2/9] coresight: remove the unnecessary replicator property
In-Reply-To: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422289345-2084-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

Now we use the device name to identify replicator instead
of a unique number, so just remove it.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index d790f49066f3..a3089359aaa6 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -38,8 +38,6 @@ its hardware characteristcs.
 	  AMBA markee):
 		- "arm,coresight-replicator"
 
-	* id: a unique number that will identify this replicator.
-
 	* port or ports: same as above.
 
 * Optional properties for ETM/PTMs:
@@ -94,8 +92,6 @@ Example:
 		 * AMBA bus.  As such no need to add "arm,primecell".
 		 */
 		compatible = "arm,coresight-replicator";
-		/* this will show up in debugfs as "0.replicator" */
-		id = <0>;
 
 		ports {
 			#address-cells = <1>;
-- 
1.9.1
