From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 12:20:07 +0000
Subject: [PATCH 4/4] arm64: kconfig: select HAVE_EFFICIENT_UNALIGNED_ACCESS
In-Reply-To: <1387282807-6024-1-git-send-email-will.deacon@arm.com>
References: <1387282807-6024-1-git-send-email-will.deacon@arm.com>
Message-ID: <1387282807-6024-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8 CPUs can perform efficient unaligned memory accesses in hardware
and this feature is relied up on by code such as the dcache
word-at-a-time name hashing.

This patch selects HAVE_EFFICIENT_UNALIGNED_ACCESS for arm64.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 435c9bc1c86c..cb9421b540c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -27,6 +27,7 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_MEMBLOCK
-- 
1.8.2.2
