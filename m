From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 10:49:30 -0700
Subject: [PATCH] clocksource: always define CLOCKSOURCE_OF_DECLARE
Message-ID: <1359568170-26479-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This allows clocksource drivers that support both DT and non-DT to
always invoke macro CLOCKSOURCE_OF_DECLARE(), rather than wrapping
it in a #ifdef CONFIG_CLKSRC_OF, which simplifies their code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Olof, Arnd, this is based on arm-soc's timer/cleanup branch, which is
probably the best place for this patch.

 include/linux/clocksource.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7944f14..27cfda4 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -339,6 +339,8 @@ extern void clocksource_of_init(void);
 	static const struct of_device_id __clksrc_of_table_##name	\
 		__used __section(__clksrc_of_table)			\
 		 = { .compatible = compat, .data = fn };
+#else
+#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)
 #endif
 
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
1.7.10.4
