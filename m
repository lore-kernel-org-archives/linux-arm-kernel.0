From: tony@atomide.com (Tony Lindgren)
Date: Sat, 04 Dec 2010 13:29:53 -0800
Subject: [PATCH 4/5] omap: McBSP: Make the free variable update more readable
In-Reply-To: <20101204212904.25978.22090.stgit@baageli.muru.com>
References: <20101204212904.25978.22090.stgit@baageli.muru.com>
Message-ID: <20101204212953.25978.57426.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shubhrajyoti D <shubhrajyoti@ti.com>

Using true/false instead of 1/0 to update the free variable.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f79090c..fdecd33 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -755,7 +755,7 @@ int omap_mcbsp_request(unsigned int id)
 		goto err_kfree;
 	}
 
-	mcbsp->free = 0;
+	mcbsp->free = false;
 	mcbsp->reg_cache = reg_cache;
 	spin_unlock(&mcbsp->lock);
 
@@ -815,7 +815,7 @@ err_clk_disable:
 	clk_disable(mcbsp->iclk);
 
 	spin_lock(&mcbsp->lock);
-	mcbsp->free = 1;
+	mcbsp->free = true;
 	mcbsp->reg_cache = NULL;
 err_kfree:
 	spin_unlock(&mcbsp->lock);
@@ -858,7 +858,7 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->free)
 		dev_err(mcbsp->dev, "McBSP%d was not reserved\n", mcbsp->id);
 	else
-		mcbsp->free = 1;
+		mcbsp->free = true;
 	mcbsp->reg_cache = NULL;
 	spin_unlock(&mcbsp->lock);
 
@@ -1771,7 +1771,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 	spin_lock_init(&mcbsp->lock);
 	mcbsp->id = id + 1;
-	mcbsp->free = 1;
+	mcbsp->free = true;
 	mcbsp->dma_tx_lch = -1;
 	mcbsp->dma_rx_lch = -1;
 
