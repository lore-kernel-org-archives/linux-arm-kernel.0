From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jan 2013 22:01:08 +0100
Subject: [PATCH 1/2] ARM: Kirkwood: Remove redundent USB clock alias
In-Reply-To: <1357851669-25669-1-git-send-email-andrew@lunn.ch>
References: <1357851669-25669-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357851669-25669-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that USB is instantiated via DT, and the USB DT node has a clocks
property, we no longer need a C coded clock alias. Remove it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-dt.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index dae6883..59fdb56 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -55,10 +55,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	orion_clkdev_add("0", "pcie",
 			 of_clk_get_from_provider(&clkspec));
 
-	clkspec.args[0] = CGC_BIT_USB0;
-	orion_clkdev_add(NULL, "orion-ehci.0",
-			 of_clk_get_from_provider(&clkspec));
-
 	clkspec.args[0] = CGC_BIT_PEX1;
 	orion_clkdev_add("1", "pcie",
 			 of_clk_get_from_provider(&clkspec));
-- 
1.7.10.4
