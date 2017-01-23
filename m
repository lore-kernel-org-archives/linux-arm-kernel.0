From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 13:48:26 +0100
Subject: [PATCH 1/2] clk: mediatek: add mt2701 ethernet reset
In-Reply-To: <1485175707-58528-1-git-send-email-john@phrozen.org>
References: <1485175707-58528-1-git-send-email-john@phrozen.org>
Message-ID: <1485175707-58528-2-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet clock core has a reset register that is currently not exposed
to the user. Fix this by adding the missing registration code.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 877be87..9251a65 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -66,6 +66,8 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
+	mtk_register_reset_controller(node, 1, 0x34);
+
 	return r;
 }
 
-- 
1.7.10.4
