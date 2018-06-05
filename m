From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:18 +0100
Subject: [PATCH 07/20] coresight: dts: Document usage of graph bindings
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before we update the bindings, document the current graph bindings
and usage of additional properties.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 31 +++++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 9aa30a1..ed6b555 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -52,9 +52,7 @@ its hardware characteristcs.
 	  clocks the core of that coresight component. The latter clock
 	  is optional.
 
-	* port or ports: The representation of the component's port
-	  layout using the generic DT graph presentation found in
-	  "bindings/graph.txt".
+	* port or ports: see "Graph bindings for Coresight" below.
 
 * Additional required properties for System Trace Macrocells (STM):
 	* reg: along with the physical base address and length of the register
@@ -71,7 +69,7 @@ its hardware characteristcs.
 	  AMBA markee):
 		- "arm,coresight-replicator"
 
-	* port or ports: same as above.
+	* port or ports: see "Graph bindings for Coresight" below.
 
 * Optional properties for ETM/PTMs:
 
@@ -90,6 +88,31 @@ its hardware characteristcs.
 	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
 	  use the SG mode on this system.
 
+Graph bindings for Coresight
+-------------------------------
+
+Coresight components are interconnected to create a data path for the flow of
+trace data generated from the "sources" to their collection points "sink".
+Each coresight component must describe the "input" and "output" connections.
+The connections must be described via generic DT graph bindings as described
+by the "bindings/graph.txt", where each "port" along with an "endpoint"
+component represents a hardware port and the connection.
+
+Since it is possible to have multiple connections for any coresight component
+with a specific direction of data flow, each connection must define the
+following properties to uniquely identify the connection details.
+
+ * Direction of the data flow w.r.t the component :
+   Each input port must have the following property defined at the "endpoint"
+   for the port.
+	"slave-mode"
+
+ * Hardware Port number at the component:
+     -  The hardware port number is assumed to be the address of the "port"
+         component.
+
+
+
 Example:
 
 1. Sinks
-- 
2.7.4
