From: nickhu@andestech.com (Nick Hu)
Date: Thu, 25 Oct 2018 10:24:17 +0800
Subject: [PATCH v4 4/4] nds32: Add document for NDS32 PMU.
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
Message-ID: <fb0115313c7c717b1699ce5f21d6f24df457e1d1.1540430862.git.nickhu@andestech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nickhu <nickhu@andestech.com>

The document for how to add NDS32 PMU
in devicetree.

Signed-off-by: Nickhu <nickhu@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/perf/nds32v3-pmu.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt

diff --git a/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt b/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
new file mode 100644
index 000000000000..1bd15785b4ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
@@ -0,0 +1,17 @@
+* NDS32 Performance Monitor Units
+
+NDS32 core have a PMU for counting cpu and cache events like cache misses.
+The NDS32 PMU representation in the device tree should be done as under:
+
+Required properties:
+
+- compatible :
+	"andestech,nds32v3-pmu"
+
+- interrupts : The interrupt number for NDS32 PMU is 13.
+
+Example:
+pmu{
+	compatible = "andestech,nds32v3-pmu";
+	interrupts = <13>;
+}
-- 
2.17.0
