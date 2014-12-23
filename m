From: andrew.jackson@arm.com (Andrew Jackson)
Date: Tue, 23 Dec 2014 13:56:23 +0000
Subject: [PATCH v4 1/5] ASoC: dwc: Prepare clock before use
In-Reply-To: <cover.1419342218.git.Andrew.Jackson@arm.com>
References: <cover.1419342218.git.Andrew.Jackson@arm.com>
Message-ID: <63becb5f356c25b226b9dbc5825357e894d0f08b.1419342218.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Some I2S clocks may require some time to get the clock ready
for operation and so need to be prepared before they are enabled.
So, prepare the clock as well as enabling it, but combine the
two through clk_prepare_enable.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 06d3a34..9573ec7 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -411,7 +411,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->clk))
 		return  PTR_ERR(dev->clk);
 
-	ret = clk_enable(dev->clk);
+	ret = clk_prepare_enable(dev->clk);
 	if (ret < 0)
 		goto err_clk_put;
 
-- 
1.7.1
