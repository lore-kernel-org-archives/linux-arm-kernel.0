From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:05 +0000
Subject: [PATCH 06/13] ARM: at91: PIT: make IO endian agnostic
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-7-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the use of __raw IO accessor with the readl/writel_relaxed versions
to allow the code to be used on a system running in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/clocksource/timer-atmel-pit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index b5b4d45..c0304ff 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -61,12 +61,12 @@ static inline struct pit_data *clkevt_to_pit_data(struct clock_event_device *clk
 
 static inline unsigned int pit_read(void __iomem *base, unsigned int reg_offset)
 {
-	return __raw_readl(base + reg_offset);
+	return readl_relaxed(base + reg_offset);
 }
 
 static inline void pit_write(void __iomem *base, unsigned int reg_offset, unsigned long value)
 {
-	__raw_writel(value, base + reg_offset);
+	writel_relaxed(value, base + reg_offset);
 }
 
 /*
-- 
2.1.4
