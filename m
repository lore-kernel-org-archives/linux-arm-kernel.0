From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 11:09:38 -0700
Subject: [PATCH 05/12] net: smc91x: Remove dead code
In-Reply-To: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1426270185-19510-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This config no longer exists now that mach-msm has been removed.
Delete it and the associated code.

Cc: David S. Miller <davem@davemloft.net>
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This can be acked and go through arm-soc or applied directly.

 drivers/net/ethernet/smsc/smc91x.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index be67baf5f677..6fd5643c4fba 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -237,20 +237,6 @@ SMC_outw(u16 val, void __iomem *ioaddr, int reg)
 #define RPC_LSA_DEFAULT         RPC_LED_100_10
 #define RPC_LSB_DEFAULT         RPC_LED_TX_RX
 
-#elif defined(CONFIG_ARCH_MSM)
-
-#define SMC_CAN_USE_8BIT	0
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	0
-#define SMC_NOWAIT		1
-
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_insw(a, r, p, l)	readsw((a) + (r), p, l)
-#define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		IRQF_TRIGGER_HIGH
-
 #elif defined(CONFIG_COLDFIRE)
 
 #define SMC_CAN_USE_8BIT	0
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
