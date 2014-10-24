From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 24 Oct 2014 14:37:24 +0400
Subject: [PATCH 2/5] arm: sa1100: add a clock alias for sa1111 pcmcia device
In-Reply-To: <1414147047-12892-1-git-send-email-dbaryshkov@gmail.com>
References: <1414147047-12892-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1414147047-12892-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA-1111 uses internal MMIO space offsets as a device name, so device
name for sa1111 pcmcia is 1800 (PCMCIA is at offset 0x1800).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index 53f750d..03c75a8 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -124,6 +124,8 @@ static struct clk_lookup sa11xx_clkregs[] = {
 	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
 	CLKDEV_INIT("sa11x0-fb", NULL, &clk_cpu),
 	CLKDEV_INIT("sa11x0-pcmcia", NULL, &clk_cpu),
+	/* sa1111 names devices using internal offsets, PCMCIA is at 0x1800 */
+	CLKDEV_INIT("1800", NULL, &clk_cpu),
 };
 
 static int __init sa11xx_clk_init(void)
-- 
2.1.1
