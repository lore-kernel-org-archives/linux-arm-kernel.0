From: labbott@redhat.com (Laura Abbott)
Date: Tue,  6 Dec 2016 15:50:51 -0800
Subject: [PATCHv5 05/11] mm: Introduce lm_alias
In-Reply-To: <1481068257-6367-1-git-send-email-labbott@redhat.com>
References: <1481068257-6367-1-git-send-email-labbott@redhat.com>
Message-ID: <1481068257-6367-6-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Certain architectures may have the kernel image mapped separately to
alias the linear map. Introduce a macro lm_alias to translate a kernel
image symbol into its linear alias. This is used in part with work to
add CONFIG_DEBUG_VIRTUAL support for arm64.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v5: Split off from the arm64 conversion to __pa_symbol
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a92c8d7..88556b8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -76,6 +76,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
 #endif
 
+#ifndef lm_alias
+#define lm_alias(x)	__va(__pa_symbol(x))
+#endif
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
-- 
2.7.4
