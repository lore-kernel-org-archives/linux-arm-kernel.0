From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 13 Nov 2017 19:23:48 +0530
Subject: [PATCH 2/3] irqchip/s3c24xx: pr_err() strings should end with newlines
In-Reply-To: <cover.1510580710.git.arvind.yadav.cs@gmail.com>
References: <cover.1510580710.git.arvind.yadav.cs@gmail.com>
Message-ID: <c5960c9504b5817c8af947342105f01779a8c8b9.1510580710.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/irqchip/irq-s3c24xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index c25ce5a..ec0e6a8 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -156,7 +156,7 @@ static int s3c_irq_type(struct irq_data *data, unsigned int type)
 		irq_set_handler(data->irq, handle_level_irq);
 		break;
 	default:
-		pr_err("No such irq type %d", type);
+		pr_err("No such irq type %d\n", type);
 		return -EINVAL;
 	}
 
@@ -204,7 +204,7 @@ static int s3c_irqext_type_set(void __iomem *gpcon_reg,
 			break;
 
 		default:
-			pr_err("No such irq type %d", type);
+			pr_err("No such irq type %d\n", type);
 			return -EINVAL;
 	}
 
-- 
1.9.1
