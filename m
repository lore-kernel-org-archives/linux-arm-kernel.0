From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:38 -0400
Subject: [PATCh V10 07/12] arm: mmp2: change the defintion of usb devices
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-8-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the udc/otg/ehci devices for mmp2

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mmp2.h |    4 ++++
 arch/arm/mach-mmp/mmp2.c              |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index 0764f4e..95b6bd7 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -29,6 +29,10 @@ extern struct pxa_device_desc mmp2_device_sdh2;
 extern struct pxa_device_desc mmp2_device_sdh3;
 extern struct pxa_device_desc mmp2_device_asram;
 extern struct pxa_device_desc mmp2_device_isram;
+extern struct pxa_device_desc mmp2_device_u2o;
+extern struct pxa_device_desc mmp2_device_u2ootg;
+extern struct pxa_device_desc mmp2_device_u2oehci;
+extern struct pxa_device_desc mmp2_device_u2ophy;
 
 extern struct platform_device mmp2_device_gpio;
 
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index d94d114..e7b7642 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -149,6 +149,10 @@ MMP2_DEVICE(sdh3, "sdhci-pxav3", 3, MMC4, 0xd4281800, 0x120);
 MMP2_DEVICE(asram, "asram", -1, NONE, 0xe0000000, 0x4000);
 /* 0xd1000000 ~ 0xd101ffff is reserved for secure processor */
 MMP2_DEVICE(isram, "isram", -1, NONE, 0xd1020000, 0x18000);
+MMP2_DEVICE(u2ophy, "mmp2-usb-phy", -1, NONE, 0xd4207000, 0x1ff);
+MMP2_DEVICE(u2o, "mv-udc", -1, USB_OTG, 0xd4208100, 0x1ff);
+MMP2_DEVICE(u2ootg, "mv-otg", -1, USB_OTG, 0xd4208100, 0x1ff);
+MMP2_DEVICE(u2oehci, "mv-ehci", -1, USB_OTG, 0xd4208100, 0x1ff);
 
 struct resource mmp2_resource_gpio[] = {
 	{
-- 
1.7.4.1
