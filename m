From: augulis.darius@gmail.com (Darius Augulis)
Date: Tue, 27 Jul 2010 22:55:05 +0300
Subject: [PATCH] Fix build error for mach-s3c64xx
Message-ID: <20100727195505.786.25117.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If SAMSUNG_DEV_ADC is not set, s3c6410_map_io()
tries to init undefined device s3c_device_adc.
---
 arch/arm/mach-s3c64xx/s3c6410.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 014401c..29338bd 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -54,7 +54,10 @@ void __init s3c6410_map_io(void)
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
 
+#ifdef CONFIG_SAMSUNG_DEV_ADC
 	s3c_device_adc.name	= "s3c64xx-adc";
+#endif
+
 	s3c_device_nand.name = "s3c6400-nand";
 	s3c_onenand_setname("s3c6410-onenand");
 	s3c64xx_onenand1_setname("s3c6410-onenand");
