From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue,  2 Jun 2015 14:31:48 +0200
Subject: [PATCH 03/11] clocksource/drivers/exynos_mct: Staticize struct
 clocksource
In-Reply-To: <1433248316-26320-1-git-send-email-daniel.lezcano@linaro.org>
References: <556DA1E5.1030601@linaro.org>
 <1433248316-26320-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1433248316-26320-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The struct clocksource 'mct_frc' is not exported and used outside so
make it static.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 87c2e55..8b2a9fc 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -209,7 +209,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
 	exynos4_mct_frc_start();
 }
 
-struct clocksource mct_frc = {
+static struct clocksource mct_frc = {
 	.name		= "mct-frc",
 	.rating		= 400,
 	.read		= exynos4_frc_read,
-- 
1.9.1
