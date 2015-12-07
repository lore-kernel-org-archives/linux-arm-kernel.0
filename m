From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:28 +0000
Subject: [PATCH 15/19] mfd: cs5535-mfd: Add missing line spacing and make
 local array static
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Missing a blank line after declarations
+       struct resource *res;
+       res = platform_get_resource(pdev, IORESOURCE_IO, 0);

WARNING: char * array declaration might be better as static const
+       const char *acpi_clones[] = { "olpc-xo1-pm-acpi", "olpc-xo1-sci-acpi" };

total: 0 errors, 2 warnings, 192 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index be91cb5..f9d277ff 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -60,6 +60,7 @@ static int cs5535_mfd_res_enable(struct platform_device *pdev)
 static int cs5535_mfd_res_disable(struct platform_device *pdev)
 {
 	struct resource *res;
+
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "can't fetch device resource info\n");
@@ -114,7 +115,10 @@ static struct mfd_cell cs5535_mfd_cells[] = {
 #ifdef CONFIG_OLPC
 static void cs5535_clone_olpc_cells(void)
 {
-	const char *acpi_clones[] = { "olpc-xo1-pm-acpi", "olpc-xo1-sci-acpi" };
+	static const char *acpi_clones[] = {
+		"olpc-xo1-pm-acpi",
+		"olpc-xo1-sci-acpi"
+	};
 
 	if (!machine_is_olpc())
 		return;
-- 
1.9.1
