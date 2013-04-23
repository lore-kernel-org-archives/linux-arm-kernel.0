From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Apr 2013 16:03:13 +0100
Subject: [PATCH 09/10] ARM: ux500: Remove ux500-musb platform registation when
 booting with DT
In-Reply-To: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366729394-11406-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the ux500-musb driver has been enabled for Device Tree, there is no
requirement to register it from platform code.

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
