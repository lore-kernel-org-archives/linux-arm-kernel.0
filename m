From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed, 16 Mar 2011 00:53:14 +0200
Subject: [PATCH 02/13] plat-spear: use list_move() instead of
	list_del()/list_add() combination
In-Reply-To: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
References: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
Message-ID: <1300229605-14499-2-git-send-email-kirill@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/plat-spear/clock.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index ee4f90e..1d24faf 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -267,9 +267,7 @@ static void change_parent(struct clk *cclk, struct clk *pclk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	list_del(&cclk->sibling);
-	list_add(&cclk->sibling, &pclk->children);
-
+	list_move(&cclk->sibling, &pclk->children);
 	cclk->pclk = pclk;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
-- 
1.7.4.1
