From: oss@buserror.net (Scott Wood)
Date: Thu, 22 Sep 2016 03:35:15 -0500
Subject: [PATCH v6 1/4] arm64: arch_timer: Add device tree binding for
 A-008585 erratum
Message-ID: <1474533318-7796-1-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This erratum describes a bug in logic outside the core, so MIDR can't be
used to identify its presence, and reading an SoC-specific revision
register from common arch timer code would be awkward.  So, describe it
in the device tree.

Signed-off-by: Scott Wood <oss@buserror.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/arch_timer.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
index e774128..ef5fbe9 100644
--- a/Documentation/devicetree/bindings/arm/arch_timer.txt
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -25,6 +25,12 @@ to deliver its interrupts via SPIs.
 - always-on : a boolean property. If present, the timer is powered through an
   always-on power domain, therefore it never loses context.
 
+- fsl,erratum-a008585 : A boolean property. Indicates the presence of
+  QorIQ erratum A-008585, which says that reading the counter is
+  unreliable unless the same value is returned by back-to-back reads.
+  This also affects writes to the tval register, due to the implicit
+  counter read.
+
 ** Optional properties:
 
 - arm,cpu-registers-not-fw-configured : Firmware does not initialize
-- 
2.7.4
