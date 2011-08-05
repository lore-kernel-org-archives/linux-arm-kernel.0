From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 5 Aug 2011 15:32:32 +0530
Subject: [PATCH V3 07/20] dmaengine/amba-pl08x: Changing few prints to dev_dbg
	from dev_info
In-Reply-To: <cover.1312538034.git.viresh.kumar@st.com>
References: <cover.1312538034.git.viresh.kumar@st.com>
Message-ID: <49528b8e03fdb19f458b979da32c092ee0aa7dc0.1312538034.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 8 memory and 16 slave channels 35 boot print lines are printed. And that is
too much. Most of this would be more useful for debugging. So moving few of them
to dev_dbg instead of dev_info. Now only 3 prints will be printed.

This also rearrange one of the debug message to fit into two lines.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6c52959..ead88c9 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1717,7 +1717,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			kfree(chan);
 			continue;
 		}
-		dev_info(&pl08x->adev->dev,
+		dev_dbg(&pl08x->adev->dev,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
 
@@ -1945,9 +1945,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		spin_lock_init(&ch->lock);
 		ch->serving = NULL;
 		ch->signal = -1;
-		dev_info(&adev->dev,
-			 "physical channel %d is %s\n", i,
-			 pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
+		dev_dbg(&adev->dev, "physical channel %d is %s\n",
+			i, pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
 	}
 
 	/* Register as many memcpy channels as there are physical channels */
-- 
1.7.2.2
