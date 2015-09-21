From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 21 Sep 2015 15:33:45 +0200
Subject: [PATCH 13/38] ARM: shmobile: apmu: correct type of CPU id
In-Reply-To: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1442842450-29769-14-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU id can be negative, so it cannot be assigned to unsigned variable.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 4e54512..292c67b 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -88,7 +88,7 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
 			   struct rcar_apmu_config *apmu_config, int num)
 {
-	u32 id;
+	int id;
 	int k;
 	int bit, index;
 	bool is_allowed;
-- 
1.9.1
