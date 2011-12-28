From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 28 Dec 2011 16:03:23 +0900
Subject: [PATCH 2/6] ARM: SAMSUNG: Fix memory size for hsotg
In-Reply-To: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
References: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1325055807-29347-2-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device link core registers for hsotg is base + 0000h ~ base +
11000h.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/devs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e5138ee..60da822 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1435,7 +1435,7 @@ void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
 
 #ifdef CONFIG_S3C_DEV_USB_HSOTG
 static struct resource s3c_usb_hsotg_resources[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_USB_HSOTG, SZ_16K),
+	[0] = DEFINE_RES_MEM(S3C_PA_USB_HSOTG, SZ_128K),
 	[1] = DEFINE_RES_IRQ(IRQ_OTG),
 };
 
-- 
1.7.5.4
