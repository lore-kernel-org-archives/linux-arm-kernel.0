From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:50 +0200
Subject: [PULL 40/79] arm64: hyp-stub: Update documentation in asm/virt.h
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-41-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Comments in asm/virt.h are slightly out of date, so let's align
them with the new behaviour of the code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/include/asm/virt.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 1466d14..1569c3a 100644
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
2.9.0
