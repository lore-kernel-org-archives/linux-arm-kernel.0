From: stefan@agner.ch (Stefan Agner)
Date: Sun, 12 Oct 2014 20:13:56 +0200
Subject: [RFC 2/7] clocksource: add dependencies for Vybrid pit clocksource
In-Reply-To: <cover.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
Message-ID: <603e0f51e88b5643cb42e966cbb1b80b21a55ecf.1413136383.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the minimal dependencies required to use the Vybrid PIT
clocksource driver. Those are not part of the SoC dependencies.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clocksource/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfd6519..26464dd 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -146,6 +146,8 @@ config FSL_FTM_TIMER
 
 config VF_PIT_TIMER
 	bool
+	select CLKSRC_MMIO
+	select CLKSRC_OF
 	help
 	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
 
-- 
2.1.2
