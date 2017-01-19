From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 19 Jan 2017 21:35:13 +0800
Subject: [PATCH v9 1/4] arm64: arch_timer: Add device tree binding for
 hisilicon-161010101 erratum
In-Reply-To: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1484832916-7248-2-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This erratum describes a bug in logic outside the core, so MIDR can't be
used to identify its presence, and reading an SoC-specific revision
register from common arch timer code would be awkward.  So, describe it
in the device tree.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
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
1.9.0
