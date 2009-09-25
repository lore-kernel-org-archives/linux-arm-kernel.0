From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 25 Sep 2009 14:17:55 -0400
Subject: [PATCH] sa1111: CodingStyle cleanups
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D426F5@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXPORT_* macros should follow immediately after the closing function
brace line.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index ef12794..8ba7044 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1032,6 +1032,7 @@ unsigned int sa1111_pll_clock(struct sa1111_dev *sadev)
 
 	return __sa1111_pll_clock(sachip);
 }
+EXPORT_SYMBOL(sa1111_pll_clock);
 
 /**
  *	sa1111_select_audio_mode - select I2S or AC link mode
@@ -1059,6 +1060,7 @@ void sa1111_select_audio_mode(struct sa1111_dev *sadev, int mode)
 
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
+EXPORT_SYMBOL(sa1111_select_audio_mode);
 
 /**
  *	sa1111_set_audio_rate - set the audio sample rate
@@ -1083,6 +1085,7 @@ int sa1111_set_audio_rate(struct sa1111_dev *sadev, int rate)
 
 	return 0;
 }
+EXPORT_SYMBOL(sa1111_set_audio_rate);
 
 /**
  *	sa1111_get_audio_rate - get the audio sample rate
@@ -1100,6 +1103,7 @@ int sa1111_get_audio_rate(struct sa1111_dev *sadev)
 
 	return __sa1111_pll_clock(sachip) / (256 * div);
 }
+EXPORT_SYMBOL(sa1111_get_audio_rate);
 
 void sa1111_set_io_dir(struct sa1111_dev *sadev,
 		       unsigned int bits, unsigned int dir,
@@ -1128,6 +1132,7 @@ void sa1111_set_io_dir(struct sa1111_dev *sadev,
 	MODIFY_BITS(gpio + SA1111_GPIO_PCSDR, (bits >> 16) & 255, sleep_dir >> 16);
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
+EXPORT_SYMBOL(sa1111_set_io_dir);
 
 void sa1111_set_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v)
 {
@@ -1142,6 +1147,7 @@ void sa1111_set_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v)
 	MODIFY_BITS(gpio + SA1111_GPIO_PCDWR, (bits >> 16) & 255, v >> 16);
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
+EXPORT_SYMBOL(sa1111_set_io);
 
 void sa1111_set_sleep_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v)
 {
@@ -1156,6 +1162,7 @@ void sa1111_set_sleep_io(struct sa1111_dev *sadev, unsigned int bits, unsigned i
 	MODIFY_BITS(gpio + SA1111_GPIO_PCSSR, (bits >> 16) & 255, v >> 16);
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
+EXPORT_SYMBOL(sa1111_set_sleep_io);
 
 /*
  * Individual device operations.
@@ -1176,6 +1183,7 @@ void sa1111_enable_device(struct sa1111_dev *sadev)
 	sa1111_writel(val | sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
+EXPORT_SYMBOL(sa1111_enable_device);
 
 /**
  *	sa1111_disable_device - disable an on-chip SA1111 function block
@@ -1192,6 +1200,7 @@ void sa1111_disable_device(struct sa1111_dev *sadev)
 	sa1111_writel(val & ~sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
 	spin_unlock_irqrestore(&sachip->lock, flags);
 }
+EXPORT_SYMBOL(sa1111_disable_device);
 
 /*
  *	SA1111 "Register Access Bus."
@@ -1259,17 +1268,20 @@ struct bus_type sa1111_bus_type = {
 	.suspend	= sa1111_bus_suspend,
 	.resume		= sa1111_bus_resume,
 };
+EXPORT_SYMBOL(sa1111_bus_type);
 
 int sa1111_driver_register(struct sa1111_driver *driver)
 {
 	driver->drv.bus = &sa1111_bus_type;
 	return driver_register(&driver->drv);
 }
+EXPORT_SYMBOL(sa1111_driver_register);
 
 void sa1111_driver_unregister(struct sa1111_driver *driver)
 {
 	driver_unregister(&driver->drv);
 }
+EXPORT_SYMBOL(sa1111_driver_unregister);
 
 static int __init sa1111_init(void)
 {
@@ -1290,16 +1302,3 @@ module_exit(sa1111_exit);
 
 MODULE_DESCRIPTION("Intel Corporation SA1111 core driver");
 MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(sa1111_select_audio_mode);
-EXPORT_SYMBOL(sa1111_set_audio_rate);
-EXPORT_SYMBOL(sa1111_get_audio_rate);
-EXPORT_SYMBOL(sa1111_set_io_dir);
-EXPORT_SYMBOL(sa1111_set_io);
-EXPORT_SYMBOL(sa1111_set_sleep_io);
-EXPORT_SYMBOL(sa1111_enable_device);
-EXPORT_SYMBOL(sa1111_disable_device);
-EXPORT_SYMBOL(sa1111_pll_clock);
-EXPORT_SYMBOL(sa1111_bus_type);
-EXPORT_SYMBOL(sa1111_driver_register);
-EXPORT_SYMBOL(sa1111_driver_unregister); 
