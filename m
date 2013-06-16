From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 16 Jun 2013 22:54:13 +0200
Subject: [RFC PATCH 06/11] dma: amba-pl08x: Keep LLIs aligned to 4-word
 boundary
In-Reply-To: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1371416058-22047-7-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PL080 reference manual states that to LLI entries should be aligned
to 4-word boundary to make LLI fetches more efficient. This patch adds
a 3-word padding to the LLi struct to make this condition true.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/dma/amba-pl08x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index eb10eb8..0da5539 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -127,6 +127,7 @@ struct pl08x_lli {
 	u32 lli;
 	u32 cctl;
 	u32 cctl1;
+	u32 dummy[3];
 };
 
 /**
-- 
1.8.2.1
