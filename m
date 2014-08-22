From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:17 +0000
Subject: [PATCH 9/9] arm64: Add new cpu-return-addr device tree binding
In-Reply-To: <cover.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
Message-ID: <4192d403bb9703063c59a052293faa19d38d2f02.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new arm64 device tree binding cpu-return-addr.  This binding is recomended
for all ARM v8 CPUs that have an "enable-method" property value of "spin-table".
The value is a 64 bit physical address that secondary CPU execution will transfer
to upon CPU shutdown.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 1fe72a0..42d5d5f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -201,6 +201,15 @@ nodes to be present and contain the properties described below.
 			  property identifying a 64-bit zero-initialised
 			  memory location.
 
+	- cpu-return-addr
+		Usage: recomended for all ARM v8 CPUs that have an
+		       "enable-method" property value of "spin-table".
+		Value type: <prop-encoded-array>
+		Definition:
+			# On ARM v8 64-bit systems must be a two cell property.
+			The value is a 64 bit physical address that secondary
+			CPU execution will transfer to upon CPU shutdown.
+
 	- qcom,saw
 		Usage: required for systems that have an "enable-method"
 		       property value of "qcom,kpss-acc-v1" or
@@ -285,6 +294,7 @@ cpus {
 		reg = <0x0 0x0>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 1 {
@@ -293,6 +303,7 @@ cpus {
 		reg = <0x0 0x1>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100 {
@@ -301,6 +312,7 @@ cpus {
 		reg = <0x0 0x100>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 101 {
@@ -309,6 +321,7 @@ cpus {
 		reg = <0x0 0x101>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 10000 {
@@ -317,6 +330,7 @@ cpus {
 		reg = <0x0 0x10000>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 10001 {
@@ -325,6 +339,7 @@ cpus {
 		reg = <0x0 0x10001>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 10100 {
@@ -333,6 +348,7 @@ cpus {
 		reg = <0x0 0x10100>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 10101 {
@@ -341,6 +357,7 @@ cpus {
 		reg = <0x0 0x10101>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100000000 {
@@ -349,6 +366,7 @@ cpus {
 		reg = <0x1 0x0>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100000001 {
@@ -357,6 +375,7 @@ cpus {
 		reg = <0x1 0x1>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100000100 {
@@ -365,6 +384,7 @@ cpus {
 		reg = <0x1 0x100>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100000101 {
@@ -373,6 +393,7 @@ cpus {
 		reg = <0x1 0x101>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100010000 {
@@ -381,6 +402,7 @@ cpus {
 		reg = <0x1 0x10000>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100010001 {
@@ -389,6 +411,7 @@ cpus {
 		reg = <0x1 0x10001>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100010100 {
@@ -397,6 +420,7 @@ cpus {
 		reg = <0x1 0x10100>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 
 	cpu at 100010101 {
@@ -405,6 +429,7 @@ cpus {
 		reg = <0x1 0x10101>;
 		enable-method = "spin-table";
 		cpu-release-addr = <0 0x20000000>;
+		cpu-return-addr = <0 0x20001000>
 	};
 };
 
-- 
1.9.1
