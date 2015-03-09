From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Mar 2015 10:27:07 +0000
Subject: [PATCH 3/6] arm64: add support for memtest
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1425896830-19705-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for memtest command line option.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/init.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ae85da6..597831b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -190,6 +190,8 @@ void __init bootmem_init(void)
 	min = PFN_UP(memblock_start_of_DRAM());
 	max = PFN_DOWN(memblock_end_of_DRAM());
 
+	early_memtest(min << PAGE_SHIFT, max << PAGE_SHIFT);
+
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
-- 
1.7.9.5
