From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 1 Aug 2011 15:07:17 +0530
Subject: [PATCH V2 07/20] dmaengine/amba-pl08x: Changing few prints to dev_dbg
	from dev_info
In-Reply-To: <cover.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
Message-ID: <5752f0202ff197d548999395d68131053693e4b3.1312190881.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 8 memory and 16 slave channels 35 boot print lines are printed. And that is
too much. Most of this would be more useful for debugging. So moving few of them
to dev_dbg instead of dev_info. Now only 3 prints will be printed.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6c52959..3fbaf0e 100644
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
 
@@ -1945,7 +1945,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		spin_lock_init(&ch->lock);
 		ch->serving = NULL;
 		ch->signal = -1;
-		dev_info(&adev->dev,
+		dev_dbg(&adev->dev,
 			 "physical channel %d is %s\n", i,
 			 pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
 	}
-- 
1.7.2.2
