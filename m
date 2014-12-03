From: stefan@agner.ch (Stefan Agner)
Date: Wed,  3 Dec 2014 01:12:07 +0100
Subject: [PATCH 08/12] clocksource: add dependencies for Vybrid pit clocksource
In-Reply-To: <1417565531-4507-1-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
Message-ID: <1417565531-4507-9-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the minimal dependencies required to use the Vybrid PIT
clocksource driver. Those are not part of the SoC dependencies.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clocksource/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9042060..7d757b7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -153,6 +153,8 @@ config FSL_FTM_TIMER
 
 config VF_PIT_TIMER
 	bool
+	select CLKSRC_MMIO
+	select CLKSRC_OF
 	help
 	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
 
-- 
2.1.3
