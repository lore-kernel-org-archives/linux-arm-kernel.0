From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 22 Jun 2016 09:01:03 -0600
Subject: [PATCH V2] coresight: document binding acronyms
Message-ID: <1466607663-22599-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can be hard for people not familiar with the CoreSight IP blocks
to make sense of the acronyms found in the current bindings.  As such
this patch expands each acronym in the hope of providing a better
description of the IP block they represent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../devicetree/bindings/arm/coresight.txt          | 35 +++++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

Changes since V1:
   - Expanded ETB, ETF and ETR acronyms.
   - Added note about using the same binding
     for all 3 modes (ETB, ETF, ETR).

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 93147c0c8a0e..fcbae6a5e6c1 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -12,14 +12,33 @@ its hardware characteristcs.
 
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
+		- Trace Memory Controller, used for Embedded Trace Buffer(ETB),
+		  Embedded Trace FIFO(ETF) and Embedded Trace Router(ETR)
+		  configuration.  The configuration mode (ETB, ETF, ETR) is
+		  discovered at boot time when the device is probed.
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
