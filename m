From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Mon, 21 Apr 2014 17:19:16 +0530
Subject: [PATCH 2/4] driver: cpuidle: cpuidle-big-little: init driver for
 Exynos5420
In-Reply-To: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1398080958-21677-3-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "samsung,exynos5420" compatible string to initialize generic
big-little cpuidle driver for Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.org>
---
 drivers/cpuidle/cpuidle-big_little.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index b45fc62..d0fac53 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -170,7 +170,8 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
+	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7") &&
+		(!of_machine_is_compatible("samsung,exynos5420")))
 		return -ENODEV;
 	/*
 	 * For now the differentiation between little and big cores
-- 
1.7.9.5
