From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 20 Sep 2010 15:52:32 +1000
Subject: [PATCH] arm: arm7tdmi needs an empty cpu_arm7tdmi_set_pte_ext
Message-ID: <201009200552.o8K5qWTA005122@goober.internal.moreton.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm: arm7tdmi needs an empty cpu_arm7tdmi_set_pte_ext

The arm7tdmi support needs to define a set_pte_ext function.
Otherwise you get:

  LD      .tmp_vmlinux1
arch/arm/mm/built-in.o:(__ksymtab+0xc8): undefined reference to `cpu_arm7tdmi_set_pte_ext'

Signed-off-by: Greg Ungerer <gerg@uclinux.org>

---
 arch/arm/mm/proc-arm7tdmi.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 6a850db..c0de842 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -23,6 +23,7 @@
  * cpu_arm7tdmi_do_idle()
  * cpu_arm7tdmi_dcache_clean_area()
  * cpu_arm7tdmi_switch_mm()
+ * cpu_arm7tdmi_set_pte_ext()
  *
  * These are not required.
  */
@@ -30,6 +31,7 @@ ENTRY(cpu_arm7tdmi_proc_init)
 ENTRY(cpu_arm7tdmi_do_idle)
 ENTRY(cpu_arm7tdmi_dcache_clean_area)
 ENTRY(cpu_arm7tdmi_switch_mm)
+ENTRY(cpu_arm7tdmi_set_pte_ext)
 		mov	pc, lr
 
 /*
