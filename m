From: luisbg@kernel.org (Luis de Bethencourt)
Date: Tue, 23 Jan 2018 11:41:12 +0000
Subject: [PATCH] clocksource/drivers/timer_sun5i: Fix trailing semicolon
Message-ID: <20180123114112.31297-1-luisbg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 drivers/clocksource/timer-sun5i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 2a3fe83ec337..3b56ea3f52af 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -334,7 +334,7 @@ static int __init sun5i_timer_init(struct device_node *node)
 	timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(timer_base)) {
 		pr_err("Can't map registers\n");
-		return PTR_ERR(timer_base);;
+		return PTR_ERR(timer_base);
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
-- 
2.15.1
