From: stefan@agner.ch (Stefan Agner)
Date: Fri,  3 Apr 2015 21:44:46 +0200
Subject: [PATCH v4 05/11] clocksource: add dependencies for Vybrid pit
 clocksource
In-Reply-To: <1428090292-21693-1-git-send-email-stefan@agner.ch>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
Message-ID: <1428090292-21693-6-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the minimal dependencies required to use the Vybrid PIT
clocksource driver. Those are not part of the SoC dependencies.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clocksource/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1c2506f..350e742 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -164,6 +164,8 @@ config FSL_FTM_TIMER
 
 config VF_PIT_TIMER
 	bool
+	select CLKSRC_MMIO
+	select CLKSRC_OF
 	help
 	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
 
-- 
2.3.5
