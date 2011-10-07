From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  7 Oct 2011 17:25:12 +0530
Subject: [PATCH V2 1/2] ARM: S3C2410: Add __init attribute to usb_simtec_init()
In-Reply-To: <1317988513-20800-1-git-send-email-tushar.behera@linaro.org>
References: <1317988513-20800-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1317988513-20800-2-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb_simtec_init() references s3c_ohci_set_platdata() which is defined
with __init attribute. Hence to remove section mismatch warning, __init
attribute is added to usb_simtec_init().

It removes following two warnigs.

WARNING: vmlinux.o(.text+0x1460c): Section mismatch in reference from
the function     usb_simtec_init() to the function
 .init.text:s3c_ohci_set_platdata()
The function usb_simtec_init() references the function
 __init s3c_ohci_set_platdata().

WARNING: vmlinux.o(.text+0x14650): Section mismatch in reference from
the function     usb_simtec_init() to the (unknown reference)
.init.data:(unknown)
The function usb_simtec_init() references the (unknown reference)
__initdata (unknown).

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c2410/usb-simtec.c |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c2410/usb-simtec.c
index 29bd3d9..3a1028c 100644
--- a/arch/arm/mach-s3c2410/usb-simtec.c
+++ b/arch/arm/mach-s3c2410/usb-simtec.c
@@ -104,7 +104,7 @@ static struct s3c2410_hcd_info usb_simtec_info __initdata = {
 };
 
 
-int usb_simtec_init(void)
+int __init usb_simtec_init(void)
 {
 	int ret;
 
diff --git a/arch/arm/mach-s3c2410/usb-simtec.h b/arch/arm/mach-s3c2410/usb-simtec.h
index 03842ed..43cc88f 100644
--- a/arch/arm/mach-s3c2410/usb-simtec.h
+++ b/arch/arm/mach-s3c2410/usb-simtec.h
@@ -12,5 +12,5 @@
  * published by the Free Software Foundation.
 */
 
-extern int usb_simtec_init(void);
+extern int __init usb_simtec_init(void);
 
-- 
1.7.4.1
