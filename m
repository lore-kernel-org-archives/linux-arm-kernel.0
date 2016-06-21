From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 21 Jun 2016 12:41:26 -0600
Subject: [PATCH] coresight: document binding acronyms
Message-ID: <1466534486-22422-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can be hard for people not familiar with the CoreSight IP blocks
to make sense of the acronyms found in the current bindings.  As such
this patch expands each acronym in the hope of providing a better
description of the IP block they represent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../devicetree/bindings/arm/coresight.txt          | 32 ++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 93147c0c8a0e..c73a7f773998 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -12,14 +12,30 @@ its hardware characteristcs.
 
 	* compatible: These have to be supplemented with "arm,primecell" as
 	  drivers are using the AMBA bus interface.  Possible values include:
-		- "arm,coresight-etb10", "arm,primecell";
-		- "arm,coresight-tpiu", "arm,primecell";
-		- "arm,coresight-tmc", "arm,primecell";
-		- "arm,coresight-funnel", "arm,primecell";
-		- "arm,coresight-etm3x", "arm,primecell";
-		- "arm,coresight-etm4x", "arm,primecell";
-		- "qcom,coresight-replicator1x", "arm,primecell";
-		- "arm,coresight-stm", "arm,primecell"; [1]
+		- Embedded Trace Buffer (version 1.0):
+			"arm,coresight-etb10", "arm,primecell";
+
+		- Trace Port Interface Unit:
+			"arm,coresight-tpiu", "arm,primecell";
+
+		- Trace Memory Controller (ETB, ETF, ETR):
+			"arm,coresight-tmc", "arm,primecell";
+
+		- Trace Funnel:
+			"arm,coresight-funnel", "arm,primecell";
+
+		- Embedded Trace Macrocell (version 3.x) and
+					Program Flow Trace Macrocell:
+			"arm,coresight-etm3x", "arm,primecell";
+
+		- Embedded Trace Macrocell (version 4.x):
+			"arm,coresight-etm4x", "arm,primecell";
+
+		- Qualcomm Configurable Replicator (version 1.x):
+			"qcom,coresight-replicator1x", "arm,primecell";
+
+		- System Trace Macrocell:
+			"arm,coresight-stm", "arm,primecell"; [1]
 
 	* reg: physical base address and length of the register
 	  set(s) of the component.
-- 
2.7.4
