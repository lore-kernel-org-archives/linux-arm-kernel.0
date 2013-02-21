From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 20 Feb 2013 23:07:16 -0500
Subject: [V8 PATCH 06/16] arm: pxa910: change the defintion of usb devices
In-Reply-To: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361419646-9052-7-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

because phy is seperated from the usb controller driver,
we can use the common pxa_device_desc for device register.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/include/mach/pxa910.h |    7 ++++---
 arch/arm/mach-mmp/pxa910.c              |    4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 3b58a3b..26ea4fe 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -20,9 +20,10 @@ extern struct pxa_device_desc pxa910_device_pwm2;
 extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
-extern struct platform_device pxa168_device_u2o;
-extern struct platform_device pxa168_device_u2ootg;
-extern struct platform_device pxa168_device_u2oehci;
+extern struct pxa_device_desc pxa910_device_u2o;
+extern struct pxa_device_desc pxa910_device_u2ootg;
+extern struct pxa_device_desc pxa910_device_u2oehci;
+extern struct pxa_device_desc pxa910_device_u2ophy;
 
 extern struct platform_device pxa910_device_gpio;
 extern struct platform_device pxa910_device_rtc;
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 8b1e16f..65174f7 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -138,6 +138,10 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
 PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+PXA910_DEVICE(u2ophy, "pxa910-usb-phy", -1, NONE, 0xd4207000, 0x1ff);
+PXA910_DEVICE(u2o, "mv-udc", -1, USB1, 0xd4208100, 0x1ff);
+PXA910_DEVICE(u2ootg, "mv-otg", -1, USB1, 0xd4208100, 0x1ff);
+PXA910_DEVICE(u2oehci, "mv-ehci", -1, USB1, 0xd4208100, 0x1ff);
 
 struct resource pxa910_resource_gpio[] = {
 	{
-- 
1.7.4.1
