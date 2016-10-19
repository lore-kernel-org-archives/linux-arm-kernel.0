From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 19 Oct 2016 15:33:47 -0500
Subject: [PATCH v2 4/4] ARM: keystone: Drop PM domain support for k2g
In-Reply-To: <20161019203347.17893-1-d-gerlach@ti.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
Message-ID: <20161019203347.17893-5-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

K2G will use a different power domain driver than the rest of the
keystone family in order to make use of the TI SCI protocol so prevent
the standard keystone pm_domain code from registering itself in
preparation for a new driver.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-keystone/pm_domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 8cbb35765a19..fe57e2692629 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -32,7 +32,9 @@ static struct pm_clk_notifier_block platform_domain_notifier = {
 };
 
 static const struct of_device_id of_keystone_table[] = {
-	{.compatible = "ti,keystone"},
+	{.compatible = "ti,k2hk"},
+	{.compatible = "ti,k2e"},
+	{.compatible = "ti,k2l"},
 	{ /* end of list */ },
 };
 
-- 
2.9.3
