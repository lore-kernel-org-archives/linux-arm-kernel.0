From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 23 Sep 2011 17:23:42 +0530
Subject: [PATCH 2/7] ARM: SAMSUNG: Add CLK Macro for clkdev support
In-Reply-To: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
References: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
Message-ID: <1316778827-24694-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/plat-samsung/include/plat/clock.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 73c66d4..c864825 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -17,6 +17,13 @@
 
 struct clk;
 
+#define CLK(dev, con, ck)	\
+	{			\
+		.dev_id = dev,	\
+		.con_id = con,	\
+		.clk = ck,	\
+	}
+
 /**
  * struct clk_ops - standard clock operations
  * @set_rate: set the clock rate, see clk_set_rate().
-- 
1.7.4.4
