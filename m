From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:20 -0800
Subject: [PATCHv3 03/16] arm64: Use set_memory.h header
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-4-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The set_memory_* functions have moved to set_memory.h. Use that header
explicitly.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Alphabetical order
---
 arch/arm64/mm/pageattr.c      | 1 +
 arch/arm64/net/bpf_jit_comp.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 8def55e..26839f2 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -17,6 +17,7 @@
 #include <linux/vmalloc.h>
 
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 
 struct page_change_data {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a785554..efc1bf2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -27,6 +27,7 @@
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
+#include <asm/set_memory.h>
 
 #include "bpf_jit.h"
 
-- 
2.7.4
