From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jan 2013 22:01:09 +0100
Subject: [PATCH 2/2] ARM: Kirkwood: Remove redundent SDIO clock alias
In-Reply-To: <1357851669-25669-1-git-send-email-andrew@lunn.ch>
References: <1357851669-25669-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357851669-25669-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that SDIO is instantiated via DT, and the SDIO DT node has a clocks
property, we no longer need a C coded clock alias. Remove it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-dt.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 59fdb56..7bae36c 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -62,11 +62,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	clkspec.args[0] = CGC_BIT_GE1;
 	orion_clkdev_add(NULL, "mv643xx_eth_port.1",
 			 of_clk_get_from_provider(&clkspec));
-
-	clkspec.args[0] = CGC_BIT_SDIO;
-	orion_clkdev_add(NULL, "mvsdio",
-			 of_clk_get_from_provider(&clkspec));
-
 }
 
 static void __init kirkwood_of_clk_init(void)
-- 
1.7.10.4
