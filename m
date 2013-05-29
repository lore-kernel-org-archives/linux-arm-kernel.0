From: liuj97@gmail.com (Jiang Liu)
Date: Wed, 29 May 2013 23:08:53 +0800
Subject: [PATCH, v2 2/5] mm/ARM: fix stale comment about VALID_PAGE()
In-Reply-To: <1369840136-1491-1-git-send-email-jiang.liu@huawei.com>
References: <1369840136-1491-1-git-send-email-jiang.liu@huawei.com>
Message-ID: <1369840136-1491-3-git-send-email-jiang.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VALID_PAGE() has been removed from kernel long time ago,
so fix the comment.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/include/asm/memory.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 57870ab..0cd2a3d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -260,12 +260,6 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 /*
  * Conversion between a struct page and a physical address.
  *
- * Note: when converting an unknown physical address to a
- * struct page, the resulting pointer must be validated
- * using VALID_PAGE().  It must return an invalid struct page
- * for any physical address not corresponding to a system
- * RAM address.
- *
  *  page_to_pfn(page)	convert a struct page * to a PFN number
  *  pfn_to_page(pfn)	convert a _valid_ PFN number to struct page *
  *
-- 
1.8.1.2
