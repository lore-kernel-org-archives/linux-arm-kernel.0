From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 13 Nov 2017 19:23:49 +0530
Subject: [PATCH 3/3] irqchip/gic-v3: pr_err() strings should end with newlines
In-Reply-To: <cover.1510580710.git.arvind.yadav.cs@gmail.com>
References: <cover.1510580710.git.arvind.yadav.cs@gmail.com>
Message-ID: <62302a3bd4918e392ca3da16f9f389aa59e76cee.1510580710.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b5df99c..252fb0c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1489,7 +1489,7 @@ static void __init gic_acpi_setup_kvm_info(void)
 
 	err = gic_validate_dist_version(acpi_data.dist_base);
 	if (err) {
-		pr_err("No distributor detected at @%p, giving up",
+		pr_err("No distributor detected at @%p, giving up\n",
 		       acpi_data.dist_base);
 		goto out_dist_unmap;
 	}
-- 
1.9.1
