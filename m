From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 13:03:42 +0200
Subject: [PATCH v4 6/7] ARM: kirkwood: remove obsolete SDIO clock gate
 workaround
In-Reply-To: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1372763023-12374-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kirkwood DT boards have been converted to DT SDIO already, we can now
remove the legacy clock gate workaround for SDIO clock.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
--- 
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-kirkwood/board-dt.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 385244c..a2c8c20 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -52,10 +52,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	orion_clkdev_add("1", "pcie",
 			 of_clk_get_from_provider(&clkspec));
 
-	clkspec.args[0] = CGC_BIT_SDIO;
-	orion_clkdev_add(NULL, "mvsdio",
-			 of_clk_get_from_provider(&clkspec));
-
 	/*
 	 * The ethernet interfaces forget the MAC address assigned by
 	 * u-boot if the clocks are turned off. Until proper DT support
-- 
1.7.2.5
