From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:09 +0800
Subject: [RFC PATCH v4 31/34] early kprobes: enable early kprobes for x86.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-32-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After dealing with kprobes on ftrace, early kprobes are allowed at
function entries if FTRACE is on. Which enables it functions
practically. This patch enables its kconfig entries for X86.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c2fb8a8..ad259ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -38,6 +38,7 @@ config X86
 	select HAVE_PERF_EVENTS
 	select HAVE_IOREMAP_PROT
 	select HAVE_KPROBES
+	select HAVE_EARLY_KPROBES
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select ARCH_DISCARD_MEMBLOCK
-- 
1.8.4
