From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  2 Apr 2015 22:31:43 +0200
Subject: [PATCH 1/6] clk: add table_size member to struct clk_mux
In-Reply-To: <1428006708-13690-1-git-send-email-manabian@gmail.com>
References: <1428006708-13690-1-git-send-email-manabian@gmail.com>
Message-ID: <1428006708-13690-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding this field makes it a lot easier to loop through and register
predefined tables containing struct clk_mux elements.

Also reorder members to prevent unnecessary padding in struct.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 include/linux/clk-provider.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5591ea71a8d1..d5ee7ec7443c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -411,9 +411,10 @@ struct clk_mux {
 	void __iomem	*reg;
 	u32		*table;
 	u32		mask;
+	spinlock_t	*lock;
 	u8		shift;
 	u8		flags;
-	spinlock_t	*lock;
+	u8		table_size;
 };
 
 #define CLK_MUX_INDEX_ONE		BIT(0)
-- 
1.8.0
