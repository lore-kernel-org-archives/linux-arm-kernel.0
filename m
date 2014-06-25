From: s-anna@ti.com (Suman Anna)
Date: Tue, 24 Jun 2014 20:04:52 -0500
Subject: [PATCH 6/9] ARM: OMAP2+: Avoid mailbox legacy device creation for
 DT-boot
In-Reply-To: <1403658295-54766-1-git-send-email-s-anna@ti.com>
References: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Message-ID: <1403658295-54766-7-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy platform device for mailbox should not be created for
a DT boot, so adjust the platform device initialization logic
appropriately.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 592ba0a..708eb7d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -460,9 +460,9 @@ static int __init omap2_init_devices(void)
 	omap_init_audio();
 	omap_init_camera();
 	omap_init_hdmi_audio();
-	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
+		omap_init_mbox();
 		omap_init_mcspi();
 		omap_init_sham();
 		omap_init_aes();
-- 
2.0.0
