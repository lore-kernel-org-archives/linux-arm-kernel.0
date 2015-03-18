From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 18 Mar 2015 12:06:35 +0100
Subject: [PATCH] clocksource: atmel-st: select REGMAP_MMIO
Message-ID: <1426676795-29333-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enforce REGMAP_MMIO selection as the driver needs it. Else, it will still
compile with some warning about X1, x2 or sr being used uninitialized.

Reported-by: fengguang.wu at intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Daniel,

I think this should go through the at91 tree as the patch introducing that issue
went there.

 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 168035883afa..3cc97b217019 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -146,6 +146,7 @@ config ATMEL_PIT
 config ATMEL_ST
 	bool
 	select CLKSRC_OF
+	select REGMAP_MMIO
 
 config CLKSRC_METAG_GENERIC
 	def_bool y if METAG
-- 
2.1.0
