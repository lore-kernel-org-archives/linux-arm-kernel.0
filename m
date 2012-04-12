From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 11 Apr 2012 18:02:43 -0700
Subject: [PATCH 05/13] clk: use kzalloc in clk_register_mux
In-Reply-To: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
Message-ID: <1334192572-12499-6-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Change clk_register_mux to use kzalloc, just like what all other basic
clk registration functions do.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
Cc: Arnd Bergman <arnd.bergmann@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Zhao <richard.zhao@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk-mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index c71ad1f..50e0595 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -97,7 +97,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 {
 	struct clk_mux *mux;
 
-	mux = kmalloc(sizeof(struct clk_mux), GFP_KERNEL);
+	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
 
 	if (!mux) {
 		pr_err("%s: could not allocate mux clk\n", __func__);
-- 
1.7.5.4
