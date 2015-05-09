From: stefan@agner.ch (Stefan Agner)
Date: Sat,  9 May 2015 22:39:36 +0200
Subject: [PATCH v6 06/12] clocksource: add dependencies for Vybrid pit
 clocksource
In-Reply-To: <1431203982-13217-1-git-send-email-stefan@agner.ch>
References: <1431203982-13217-1-git-send-email-stefan@agner.ch>
Message-ID: <1431203982-13217-7-git-send-email-stefan@agner.ch>
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
index 51d7865f..9626c40 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -174,6 +174,8 @@ config FSL_FTM_TIMER
 
 config VF_PIT_TIMER
 	bool
+	select CLKSRC_MMIO
+	select CLKSRC_OF
 	help
 	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
 
-- 
2.4.0
