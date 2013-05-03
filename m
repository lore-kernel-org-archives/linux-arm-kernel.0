From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:37 +0100
Subject: [PATCH 51/63] ARM: ux500: Remove ux500-musb platform registation when
 booting with DT
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-52-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the ux500-musb driver has been enabled for Device Tree, there is no
requirement to register it from platform code.

Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 5a6b9ae..36ef6ed 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -227,8 +227,6 @@ static struct device * __init u8500_of_init_devices(void)
 {
 	struct device *parent = db8500_soc_device_init();
 
-	db8500_add_usb(parent, usb_db8500_dma_cfg, usb_db8500_dma_cfg);
-
 	return parent;
 }
 
-- 
1.7.10.4
