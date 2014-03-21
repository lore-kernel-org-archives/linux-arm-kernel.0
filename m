From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 21 Mar 2014 09:48:13 +0000
Subject: [PATCH 1/2] ARM: move outer_cache declaration out of ifdef
In-Reply-To: <20140320233920.GD24571@kroah.com>
References: <20140320233920.GD24571@kroah.com>
Message-ID: <1395395294-17848-1-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

commit 0b53c11d533a8f6688d73fad0baf67dd08ec1b90 upstream.

Move the outer_cache declaration of the CONFIG_OUTER_CACHE ifdef so that
outer_cache can be used inside IS_ENABLED condition.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
---
 arch/arm/include/asm/outercache.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 12f71a1..f94784f 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -37,10 +37,10 @@ struct outer_cache_fns {
 	void (*resume)(void);
 };
 
-#ifdef CONFIG_OUTER_CACHE
-
 extern struct outer_cache_fns outer_cache;
 
+#ifdef CONFIG_OUTER_CACHE
+
 static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
 {
 	if (outer_cache.inv_range)
-- 
1.7.10.4
