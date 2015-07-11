From: ddaney.cavm@gmail.com (David Daney)
Date: Sat, 11 Jul 2015 13:25:21 -0700
Subject: [PATCH 1/3] arm64, mm: Add flush_tlb_all_local() function.
In-Reply-To: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1436646323-10527-2-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

To be used in follow-on patch.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/tlbflush.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 934815d..42c09ec 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -105,6 +105,13 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	dsb(ish);
 }
 
+static inline void flush_tlb_all_local(void)
+{
+	dsb(ishst);
+	asm("tlbi       vmalle1");
+	isb();
+}
+
 static inline void __flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
-- 
1.9.1
