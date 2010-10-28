From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Oct 2010 11:16:45 +0100
Subject: [GIT PULL] Samsung S5P for 2.6.37 merge window
In-Reply-To: <025a01cb74fc$0d9c7890$28d569b0$%kim@samsung.com>
References: <025a01cb74fc$0d9c7890$28d569b0$%kim@samsung.com>
Message-ID: <20101028101645.GA3882@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 07:53:38PM +0900, Kukjin Kim wrote:
> Hi Russell,
> 
> Please pull Samsung S5P updates from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> for-rmk

I get a conflict for this - which I'm intending to fix up as below.
Please confirm whether this is the correct resolution.

diff --cc arch/arm/mach-s3c64xx/dev-audio.c
index 3838335,4a5c682..0000000
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@@ -22,31 -22,19 +22,20 @@@
  #include <plat/audio.h>
  #include <plat/gpio-cfg.h>
  
- #include <mach/gpio-bank-c.h>
- #include <mach/gpio-bank-d.h>
- #include <mach/gpio-bank-e.h>
- #include <mach/gpio-bank-h.h>
- 
  static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
  {
+ 	unsigned int base;
+ 
  	switch (pdev->id) {
  	case 0:
- 		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
+ 		base = S3C64XX_GPD(0);
  		break;
  	case 1:
- 		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+ 		base = S3C64XX_GPE(0);
  		break;
  	default:
 -		printk(KERN_DEBUG "Invalid I2S Controller number!");
 +		printk(KERN_DEBUG "Invalid I2S Controller number: %d\n",
 +			pdev->id);
  		return -EINVAL;
  	}
  
@@@ -170,24 -157,17 +158,18 @@@ EXPORT_SYMBOL(s3c64xx_device_iisv4)
  
  static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
  {
+ 	unsigned int base;
+ 
  	switch (pdev->id) {
  	case 0:
- 		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_PCM0_SCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_PCM0_EXTCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_PCM0_FSYNC);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_PCM0_SIN);
- 		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_PCM0_SOUT);
+ 		base = S3C64XX_GPD(0);
  		break;
  	case 1:
- 		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_PCM1_SCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_PCM1_EXTCLK);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_PCM1_FSYNC);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_PCM1_SIN);
- 		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_PCM1_SOUT);
+ 		base = S3C64XX_GPE(0);
  		break;
  	default:
 -		printk(KERN_DEBUG "Invalid PCM Controller number!");
 +		printk(KERN_DEBUG "Invalid PCM Controller number: %d\n",
 +			pdev->id);
  		return -EINVAL;
  	}
  
