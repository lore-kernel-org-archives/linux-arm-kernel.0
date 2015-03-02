From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  2 Mar 2015 14:55:45 +0000
Subject: [RFC PATCH 4/4] arm: add support for memtest
In-Reply-To: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1425308145-20769-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for memtest command line option.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/init.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1609b02..3d0e9ae 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -335,6 +335,9 @@ void __init bootmem_init(void)
 
 	find_limits(&min, &max_low, &max_high);
 
+	early_memtest((phys_addr_t)min << PAGE_SHIFT,
+		      (phys_addr_t)max_low << PAGE_SHIFT);
+
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
-- 
1.7.9.5
