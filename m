From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:45 -0500
Subject: [PATCH 33/36] dt-bindings: arm: Convert Tegra board/soc bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-34-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Tegra SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree at vger.kernel.org
Cc: linux-tegra at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/tegra.txt         | 60 -------------
 .../devicetree/bindings/arm/tegra.yaml        | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
deleted file mode 100644
index 32f62bb7006d..000000000000
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-NVIDIA Tegra device tree bindings
--------------------------------------------
-
-SoCs
--------------------------------------------
-
-Each device tree must specify which Tegra SoC it uses, using one of the
-following compatible values:
-
-  nvidia,tegra20
-  nvidia,tegra30
-  nvidia,tegra114
-  nvidia,tegra124
-  nvidia,tegra132
-  nvidia,tegra210
-  nvidia,tegra186
-  nvidia,tegra194
-
-Boards
--------------------------------------------
-
-Each device tree must specify which one or more of the following
-board-specific compatible values:
-
-  ad,medcom-wide
-  ad,plutux
-  ad,tamonten
-  ad,tec
-  compal,paz00
-  compulab,trimslice
-  nvidia,beaver
-  nvidia,cardhu
-  nvidia,cardhu-a02
-  nvidia,cardhu-a04
-  nvidia,dalmore
-  nvidia,harmony
-  nvidia,jetson-tk1
-  nvidia,norrin
-  nvidia,p2371-0000
-  nvidia,p2371-2180
-  nvidia,p2571
-  nvidia,p2771-0000
-  nvidia,p2972-0000
-  nvidia,roth
-  nvidia,seaboard
-  nvidia,tn7
-  nvidia,ventana
-  toradex,apalis_t30
-  toradex,apalis_t30-eval
-  toradex,apalis-tk1
-  toradex,apalis-tk1-eval
-  toradex,colibri_t20-512
-  toradex,colibri_t30
-  toradex,colibri_t30-eval-v3
-  toradex,iris
-
-Trusted Foundations
--------------------------------------------
-Tegra supports the Trusted Foundation secure monitor. See the
-"tlm,trusted-foundations" binding's documentation for more details.
diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
new file mode 100644
index 000000000000..9cebcfaaad1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/tegra.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra device tree bindings
+
+maintainers:
+  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
+  - Peter De Schrijver <pdeschrijver@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - compal,paz00
+              - compulab,trimslice
+              - nvidia,harmony
+              - nvidia,seaboard
+              - nvidia,ventana
+          - const: nvidia,tegra20
+      - items:
+          - enum:
+              - ad,medcom-wide
+              - ad,plutux
+              - ad,tec
+          - const: ad,tamonten
+          - const: nvidia,tegra20
+      - items:
+          - const: toradex,iris
+          - const: toradex,colibri_t20-512
+          - const: nvidia,tegra20
+      - items:
+          - enum:
+              - nvidia,beaver
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - nvidia,cardhu-a02
+              - nvidia,cardhu-a04
+          - const: nvidia,cardhu
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - toradex,apalis_t30-eval
+          - const: toradex,apalis_t30
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - toradex,colibri_t30-eval-v3
+          - const: toradex,colibri_t30
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - nvidia,dalmore
+              - nvidia,roth
+              - nvidia,tn7
+          - const: nvidia,tegra114
+      - items:
+          - enum:
+              - nvidia,jetson-tk1
+              - nvidia,venice2
+          - const: nvidia,tegra124
+      - items:
+          - const: toradex,apalis-tk1-eval
+          - const: toradex,apalis-tk1
+          - const: nvidia,tegra124
+      - items:
+          - enum:
+              - nvidia,norrin
+          - const: nvidia,tegra132
+          - const: nvidia,tegra124
+      - items:
+          - enum:
+              - nvidia,p2371-0000
+              - nvidia,p2371-2180
+              - nvidia,p2571
+          - const: nvidia,tegra210
+      - items:
+          - enum:
+              - nvidia,p2771-0000
+          - const: nvidia,tegra186
+      - items:
+          - enum:
+              - nvidia,p2972-0000
+          - const: nvidia,tegra194
-- 
2.17.1
