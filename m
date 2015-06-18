From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu, 18 Jun 2015 17:47:53 +0530
Subject: [PATCH v2 7/7] mn10300: add early_init_dt_*
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <1434629873-11668-8-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building it failed with:
undefined reference to `early_init_dt_alloc_memory_arch'
undefined reference to `early_init_dt_add_memory_arch'

Added the function after seeing them in x86.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 arch/mn10300/kernel/setup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mn10300/kernel/setup.c b/arch/mn10300/kernel/setup.c
index 2ad7f32..f0e08b0 100644
--- a/arch/mn10300/kernel/setup.c
+++ b/arch/mn10300/kernel/setup.c
@@ -87,6 +87,21 @@ static int __init early_mem(char *p)
 early_param("mem", early_mem);
 
 /*
+ * early_init_dt_add_memory_arch() and early_init_dt_alloc_memory_arch()
+ * borrowed from arch/x86/kernel/devicetree.c
+ */
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	BUG();
+}
+
+void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
+{
+	return __alloc_bootmem(size, align, 0);
+}
+
+/*
  * architecture specific setup
  */
 void __init setup_arch(char **cmdline_p)
-- 
1.8.1.2
