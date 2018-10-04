From: colin.king@canonical.com (Colin King)
Date: Thu,  4 Oct 2018 14:37:40 +0100
Subject: [PATCH] pinctrl: sirf: make const array rsc_ids static
Message-ID: <20181004133740.19913-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The const array rsc_ids can be made static, saves populating it on
the stack and will make it read-only.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 2e42d738b589..2a44b911018e 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -246,7 +246,7 @@ static struct pinctrl_desc sirfsoc_pinmux_desc = {
 
 static void __iomem *sirfsoc_rsc_of_iomap(void)
 {
-	const struct of_device_id rsc_ids[]  = {
+	static const struct of_device_id rsc_ids[]  = {
 		{ .compatible = "sirf,prima2-rsc" },
 		{}
 	};
-- 
2.17.1
