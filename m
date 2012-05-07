From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 6 May 2012 22:08:29 -0700
Subject: [PATCH 4/5] clk: mux: assign init data
In-Reply-To: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
Message-ID: <1336367310-5140-5-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original conversion to struct clk_hw_init failed to add the pointer
assignment in clk_register_mux.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/clk-mux.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 8e97491..fd36a8e 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -116,6 +116,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 	mux->width = width;
 	mux->flags = clk_mux_flags;
 	mux->lock = lock;
+	mux->hw.init = &init;
 
 	clk = clk_register(dev, &mux->hw);
 
-- 
1.7.5.4
