From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Fri, 09 Sep 2011 14:01:38 -0400
Subject: [PATCH V4 RESEND 3/6] ARM: S5P64X0: Set s3c_device_fb name
In-Reply-To: <1315591301-17166-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1315591301-17166-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1315591301-17166-4-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set s3c_device_fb name as "s5p64x0-fb" for S5P6440 and S5P6450.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/cpu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
index a5c0095..617da3b 100644
--- a/arch/arm/mach-s5p64x0/cpu.c
+++ b/arch/arm/mach-s5p64x0/cpu.c
@@ -38,6 +38,7 @@
 #include <plat/s5p6440.h>
 #include <plat/s5p6450.h>
 #include <plat/adc-core.h>
+#include <plat/fb-core.h>
 
 /* Initial IO mappings */
 
@@ -108,6 +109,7 @@ void __init s5p6440_map_io(void)
 {
 	/* initialize any device information early */
 	s3c_adc_setname("s3c64xx-adc");
+	s3c_fb_setname("s5p64x0-fb");
 
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
@@ -117,6 +119,7 @@ void __init s5p6450_map_io(void)
 {
 	/* initialize any device information early */
 	s3c_adc_setname("s3c64xx-adc");
+	s3c_fb_setname("s5p64x0-fb");
 
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
-- 
1.7.0.4
