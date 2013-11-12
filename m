From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 12 Nov 2013 07:32:11 +0400
Subject: [PATCH 4/5] arm: sa1100: add a clock alias for sa1111 pcmcia device
In-Reply-To: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
References: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384227132-10501-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index abf1dc1..cd4762d 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -124,6 +124,7 @@ static struct clk_lookup sa11xx_clkregs[] = {
 	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
 	CLKDEV_INIT("sa11x0-fb", NULL, &clk_cpu),
 	CLKDEV_INIT("sa11x0-pcmcia", NULL, &clk_cpu),
+	CLKDEV_INIT("1600", NULL, &clk_cpu), /* sa1111 pcmcia */
 };
 
 static int __init sa11xx_clk_init(void)
-- 
1.8.4.2
