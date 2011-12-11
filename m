From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 11 Dec 2011 21:11:59 +0100
Subject: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to postcore
In-Reply-To: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <1323634328-856-2-git-send-email-jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow boards with custom memory mapped GPIO ports to set up
and use those port pins while initializing devices from arch init.

Created against linux-3.2-rc5.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 drivers/gpio/gpio-generic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 4e24436..a6eaf38 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -528,7 +528,7 @@ static int __init bgpio_platform_init(void)
 {
 	return platform_driver_register(&bgpio_driver);
 }
-module_init(bgpio_platform_init);
+postcore_initcall(bgpio_platform_init);
 
 static void __exit bgpio_platform_exit(void)
 {
-- 
1.7.3.4
