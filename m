From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 26 Nov 2016 16:00:43 +0800
Subject: [PATCH v4 1/6] arm64: arch_timer: Add device tree binding for
 hisilicon-161601 erratum
In-Reply-To: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
References: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1480147248-12828-2-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This erratum describes a bug in logic outside the core, so MIDR can't be
used to identify its presence, and reading an SoC-specific revision
register from common arch timer code would be awkward.  So, describe it
in the device tree.

v2: Use the new erratum name and update the description.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
index ef5fbe9..c27b2c4 100644
--- a/Documentation/devicetree/bindings/arm/arch_timer.txt
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -31,6 +31,14 @@ to deliver its interrupts via SPIs.
   This also affects writes to the tval register, due to the implicit
   counter read.
 
+- hisilicon,erratum-161601 : A boolean property. Indicates the presence of
+  erratum 161601, which says that reading the counter is unreliable unless
+  reading twice on the register and the value of the second read is larger
+  than the first by less than 32. If the verification is unsuccessful, then
+  discard the value of this read and repeat this procedure until the verification
+  is successful.  This also affects writes to the tval register, due to the
+  implicit counter read.
+
 ** Optional properties:
 
 - arm,cpu-registers-not-fw-configured : Firmware does not initialize
-- 
1.9.0
