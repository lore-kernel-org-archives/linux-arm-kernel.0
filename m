From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 25 Sep 2017 13:46:39 +0530
Subject: [PATCH 1/3] clocksource: fttmr010: pr_err() strings should end with
 newlines
In-Reply-To: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1506327401-30521-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should terminated with a new-line to avoid
other messages being concatenated onto the end.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clocksource/timer-fttmr010.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 66dd909..32214eb 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -263,14 +263,14 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 
 	fttmr010->base = of_iomap(np, 0);
 	if (!fttmr010->base) {
-		pr_err("Can't remap registers");
+		pr_err("Can't remap registers\n");
 		ret = -ENXIO;
 		goto out_free;
 	}
 	/* IRQ for timer 1 */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
-		pr_err("Can't parse IRQ");
+		pr_err("Can't parse IRQ\n");
 		ret = -EINVAL;
 		goto out_unmap;
 	}
-- 
1.9.1
