From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 26 Feb 2013 23:59:25 +0100
Subject: [PATCH 4/5] ARM: S3C24XX: make s3c24xx_init_intc static
In-Reply-To: <201302262357.24544.heiko@sntech.de>
References: <201302262357.24544.heiko@sntech.de>
Message-ID: <201302262359.25592.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not used anywhere else.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index ee47654..8bc2931 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -428,7 +428,7 @@ static void s3c24xx_clear_intc(struct s3c_irq_intc *intc)
 	}
 }
 
-struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
+static struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 				       struct s3c_irq_data *irq_data,
 				       struct s3c_irq_intc *parent,
 				       unsigned long address)
-- 
1.7.2.3
