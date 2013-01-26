From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 16:10:29 +0100
Subject: [PATCH 2/3] ARM: Kirkwood: Revert clkdev changes.
In-Reply-To: <1359213030-18588-1-git-send-email-andrew@lunn.ch>
References: <1359213030-18588-1-git-send-email-andrew@lunn.ch>
Message-ID: <1359213030-18588-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Ethernet driver can get its clock from device tree,
revert this change which broken non-DT probing of the ethernet device.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-dt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 7ab92e5..edb1215 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -48,7 +48,7 @@ static void __init kirkwood_legacy_clk_init(void)
 	clkspec.args_count = 1;
 
 	clkspec.args[0] = CGC_BIT_GE0;
-	orion_clkdev_add(NULL, "f1072000.egiga0",
+	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
 			 of_clk_get_from_provider(&clkspec));
 
 	clkspec.args[0] = CGC_BIT_PEX0;
@@ -60,7 +60,7 @@ static void __init kirkwood_legacy_clk_init(void)
 			 of_clk_get_from_provider(&clkspec));
 
 	clkspec.args[0] = CGC_BIT_GE1;
-	orion_clkdev_add(NULL, "f1076000.egiga1",
+	orion_clkdev_add(NULL, "mv643xx_eth_port.1",
 			 of_clk_get_from_provider(&clkspec));
 }
 
-- 
1.7.10.4
