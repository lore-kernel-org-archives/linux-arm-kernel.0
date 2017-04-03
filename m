From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Apr 2017 19:37:38 +0100
Subject: [PATCH v5 05/34] arm64: hyp-stub: Update documentation in asm/virt.h
In-Reply-To: <20170403183807.1620-1-marc.zyngier@arm.com>
References: <20170403183807.1620-1-marc.zyngier@arm.com>
Message-ID: <20170403183807.1620-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comments in asm/virt.h are slightly out of date, so let's align
them with the new behaviour of the code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/virt.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 1466d14c664d..1569c3a0d794 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -19,9 +19,14 @@
 #define __ASM__VIRT_H
 
 /*
- * The arm64 hcall implementation uses x0 to specify the hcall type. A value
- * less than 0xfff indicates a special hcall, such as get/set vector.
- * Any other value is used as a pointer to the function to call.
+ * The arm64 hcall implementation uses x0 to specify the hcall
+ * number. A value less than HVC_STUB_HCALL_NR indicates a special
+ * hcall, such as set vector. Any other value is handled in a
+ * hypervisor specific way.
+ *
+ * The hypercall is allowed to clobber any of the caller-saved
+ * registers (x0-x18), so it is advisable to use it through the
+ * indirection of a function call (as implemented in hyp-stub.S).
  */
 
 /* HVC_GET_VECTORS - Return the value of the vbar_el2 register. */
-- 
2.11.0
