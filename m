From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:11 -0300
Subject: [PATCH/RESEND 9/9] drm/tilcdc: replace late_initcall with module_init
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use module_init instead of late_initcall, as is the norm for modular
drivers.

module_init was used until 6e8de0bd6a51fdeebd5d975c4fcc426f730b339b
("drm/tilcdc: add encoder slave (v2)") changed it to a late_initcall,
but it does not explain why. Tests show it's working properly with
module_init.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 2c860c4..6be623b 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -629,7 +629,7 @@ static void __exit tilcdc_drm_fini(void)
 	tilcdc_tfp410_fini();
 }
 
-late_initcall(tilcdc_drm_init);
+module_init(tilcdc_drm_init);
 module_exit(tilcdc_drm_fini);
 
 MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
-- 
2.0.0
