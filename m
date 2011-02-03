From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri,  4 Feb 2011 02:32:14 +0300
Subject: [PATCH] collie: do actually pass locomo_info to locomo driver
Message-ID: <1296775934-9903-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

locomo_info isn't actually used as a platform_data on collie platform:
 arm/mach-sa1100/collie.c:237: warning: ?locomo_info? defined but not used

So locomo driver doesn't setup IRQs correctly. Pass locomo_info to the
driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: stable at kernel.org
---
 arch/arm/mach-sa1100/collie.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index d43c5ef..bd3e1bf 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -241,6 +241,9 @@ static struct locomo_platform_data locomo_info = {
 struct platform_device collie_locomo_device = {
 	.name		= "locomo",
 	.id		= 0,
+	.dev		= {
+		.platform_data	= &locomo_info,
+	},
 	.num_resources	= ARRAY_SIZE(locomo_resources),
 	.resource	= locomo_resources,
 };
-- 
1.7.2.3
