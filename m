From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 24 Dec 2012 08:19:10 +0100
Subject: [PATCH v2 2/2] cpts: fix a run time warn_on.
In-Reply-To: <cover.1356331925.git.richardcochran@gmail.com>
References: <cover.1356331925.git.richardcochran@gmail.com>
Message-ID: <c325befd7dfbeb49f3343dfb989b823b8eee6f41.1356331925.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a warning in clk_enable by calling clk_prepare_enable
instead.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/ti/cpts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 5ab8fb4..463597f 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -247,7 +247,7 @@ static void cpts_clk_init(struct cpts *cpts)
 		cpts->refclk = NULL;
 		return;
 	}
-	clk_enable(cpts->refclk);
+	clk_prepare_enable(cpts->refclk);
 }
 
 static void cpts_clk_release(struct cpts *cpts)
-- 
1.7.2.5
