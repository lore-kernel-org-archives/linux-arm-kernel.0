From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon,  2 Dec 2013 16:20:04 +0000
Subject: [PATCH RFC 1/2] Documentation: arm: add cache DT bindings
In-Reply-To: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1386001205-11978-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM systems the cache topology cannot be probed at runtime, in
particular, it is impossible to probe which CPUs share a given cache
level. Power management software requires this knowledge to implement
optimized power down sequences, hence this patch adds a document that
defines the DT cache bindings for ARM systems. The bindings are compliant
with ePAPR (PowerPC bindings), and rely on the cache bindings already
standardized in the ePAPR v1.1 document; ARM required updates are underlined
in the binding document.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cache.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt

diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
new file mode 100644
index 0000000..009cddb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cache.txt
@@ -0,0 +1,25 @@
+==========================================
+ARM processors cache binding description
+==========================================
+
+Device tree bindings for ARM processor caches adhere to the cache bindings
+described in [3], in section 3.8 for multi-level and shared caches.
+
+On ARM, internal caches cannot be described in the cpu node but require
+specific nodes marked with compatible string set to "cache" (see [3],
+section 3.8).
+
+Furthermore the cache bindings in [3] require the following property update:
+
+- [Table 3.9] cache-level: This property of cache nodes must match the cache
+			   level encoded in the processors CLIDR (v7) and
+			   CLIDR_EL1 (v8) registers, as described in [1][2].
+
+All other properties and rules apply.
+
+[1] ARMv7-AR Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[2] ARMv8-A Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[3] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
-- 
1.8.4
