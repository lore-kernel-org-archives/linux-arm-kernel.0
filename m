From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Feb 2017 16:47:39 +0000
Subject: [PATCH 1/4] arm64: arch_timer: add dt binding for hisilicon-161010101
 erratum
In-Reply-To: <1486399662-17601-1-git-send-email-mark.rutland@arm.com>
References: <1486399662-17601-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1486399662-17601-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>

This erratum describes a bug in logic outside the core, so MIDR can't be
used to identify its presence, and reading an SoC-specific revision
register from common arch timer code would be awkward.  So, describe it
in the device tree.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/arm/arch_timer.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
index ad440a2..e926aea 100644
--- a/Documentation/devicetree/bindings/arm/arch_timer.txt
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -31,6 +31,12 @@ to deliver its interrupts via SPIs.
   This also affects writes to the tval register, due to the implicit
   counter read.
 
+- hisilicon,erratum-161010101 : A boolean property. Indicates the
+  presence of Hisilicon erratum 161010101, which says that reading the
+  counters is unreliable in some cases, and reads may return a value 32
+  beyond the correct value. This also affects writes to the tval
+  registers, due to the implicit counter read.
+
 ** Optional properties:
 
 - arm,cpu-registers-not-fw-configured : Firmware does not initialize
-- 
1.9.1
