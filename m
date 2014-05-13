From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 May 2014 12:58:41 +0200
Subject: [PATCH 04/16] mfd: db8500-prcmu: Make mfd_cell array const
In-Reply-To: <1399978733-13662-1-git-send-email-k.kozlowski@samsung.com>
References: <1399978733-13662-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1399978733-13662-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mfd_add_devices() expects array of struct mfd_cell to be const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/mfd/db8500-prcmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 7694e0700d34..93d2cdcc8aa9 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3115,7 +3115,7 @@ static int db8500_prcmu_register_ab8500(struct device *parent,
 {
 	struct device_node *np;
 	struct resource ab8500_resource;
-	struct mfd_cell ab8500_cell = {
+	const struct mfd_cell ab8500_cell = {
 		.name = "ab8500-core",
 		.of_compatible = "stericsson,ab8500",
 		.id = AB8500_VERSION_AB8500,
-- 
1.9.1
