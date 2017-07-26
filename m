From: douly.fnst@cn.fujitsu.com (Dou Liyang)
Date: Wed, 26 Jul 2017 21:34:26 +0800
Subject: [PATCH 01/11] arm64: numa: Remove the unused parent_node() macro
In-Reply-To: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
Message-ID: <1501076076-1974-2-git-send-email-douly.fnst@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of parent_node().

The parent_node() macro in ARM64 platform is unnecessary.

Remove it for cleanup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/include/asm/numa.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index bf466d1..ef7b238 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -7,9 +7,6 @@
 
 #define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
 
-/* currently, arm64 implements flat NUMA topology */
-#define parent_node(node)	(node)
-
 int __node_distance(int from, int to);
 #define node_distance(a, b) __node_distance(a, b)
 
-- 
2.5.5
