From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:01:58 +0200
Subject: [PATCH 02/18] clk: samsung: exynos3250: Move platform driver and
 of_device_id to init section
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_driver and of_device_id structs can be moved to init
section because they are referenced only from subsys_initcall-level
function.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 16575ee874cb..e26b04fea33b 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -1079,12 +1079,12 @@ static int __init exynos3250_cmu_isp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id exynos3250_cmu_isp_of_match[] = {
+static const struct of_device_id exynos3250_cmu_isp_of_match[] __initconst = {
 	{ .compatible = "samsung,exynos3250-cmu-isp", },
 	{ /* sentinel */ }
 };
 
-static struct platform_driver exynos3250_cmu_isp_driver = {
+static struct platform_driver exynos3250_cmu_isp_driver __initdata = {
 	.driver = {
 		.name = "exynos3250-cmu-isp",
 		.of_match_table = exynos3250_cmu_isp_of_match,
-- 
1.9.1
