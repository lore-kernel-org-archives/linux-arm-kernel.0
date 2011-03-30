From: bob.dunlop@xyzzy.org.uk (Bob Dunlop)
Date: Wed, 30 Mar 2011 09:22:04 +0100
Subject: [PATCH] davinci: correct RMII 50MHz mux setting
Message-ID: <20110330082204.GA16271@xyzzy.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Whilst bringing up a new board I discovered that the OMAP-L138 pin multiplexor
setting for the RMII 50 Mhz clock was incorrect.  The TI reference manual
(SPRUGM7D - April 2010) lists the bit patten to enable this function as 0x8.

With the value changed I can bring up the PHY on our board.

Signed-off-by: Bob Dunlop <bob.dunlop@xyzzy.org.uk>


--- linux-2.6.38-orig/arch/arm/mach-davinci/da850.c	2011-03-21 13:06:06.000000000 +0000
+++ linux-2.6.38/arch/arm/mach-davinci/da850.c	2011-03-25 17:15:56.000000000 +0000
@@ -440,7 +440,7 @@
 	MUX_CFG(DA850, RMII_RXD_0,	14,	24,	15,	8,	false)
 	MUX_CFG(DA850, RMII_RXD_1,	14,	20,	15,	8,	false)
 	MUX_CFG(DA850, RMII_RXER,	14,	28,	15,	8,	false)
-	MUX_CFG(DA850, RMII_MHZ_50_CLK,	15,	0,	15,	0,	false)
+	MUX_CFG(DA850, RMII_MHZ_50_CLK,	15,	0,	15,	8,	false)
 	/* McASP function */
 	MUX_CFG(DA850,	ACLKR,		0,	0,	15,	1,	false)
 	MUX_CFG(DA850,	ACLKX,		0,	4,	15,	1,	false)
-- 
        Bob Dunlop
