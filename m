From: andrew.jackson@arm.com (Andrew Jackson)
Date: Wed, 31 Dec 2014 16:20:37 +0000
Subject: [PATCH] ASoC: adi: Add missing return statement.
Message-ID: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

The probe routine was disabling the clock even
if the system was configured successfully.  Add
a return statement to leave clocks enabled.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
Spotted while reviewing clock preparation

 sound/soc/adi/axi-i2s.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
index 7752860..4c23381 100644
--- a/sound/soc/adi/axi-i2s.c
+++ b/sound/soc/adi/axi-i2s.c
@@ -240,6 +240,8 @@ static int axi_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
+	return 0;
+
 err_clk_disable:
 	clk_disable_unprepare(i2s->clk);
 	return ret;
-- 
1.7.1
