From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Nov 2010 12:13:19 +0100
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is a simple driver and there is no need to call its init function
at the level of a subsystem.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/pxa2xx_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index e76b1af..6f2f061 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1731,7 +1731,7 @@ static int __init pxa2xx_spi_init(void)
 {
 	return platform_driver_probe(&driver, pxa2xx_spi_probe);
 }
-subsys_initcall(pxa2xx_spi_init);
+module_init(pxa2xx_spi_init);
 
 static void __exit pxa2xx_spi_exit(void)
 {
-- 
1.7.3.2
