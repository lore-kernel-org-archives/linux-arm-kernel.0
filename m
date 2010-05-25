From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 25 May 2010 05:42:15 +0100
Subject: samsung merge window over
Message-ID: <20100525044214.GE7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thankyou to all who contributed to this round of updates, I am officially
calling the end of any new development work for this merge window.

Special thanks to all at Samsung for their help.

I will now be preparing a defconfig, documentation and any other bugfixes
tree to send to Linus as soon as possible.

As a note, this is the shortlog of the patches merged via my tree:

Arnaud Patard (3):
      ARM: h1940: fix touchscreen support
      ARM: S3C24XX: fix s3c2410fb platdata passing
      ARM: S3C24XX: s3c24xx_mci_set_platdata should be marked __init

Atul Dahiya (1):
      ARM: SAMSUNG: Move RTC device definitions in plat-samsung

Banajit Goswami (4):
      ARM: SAMSUNG: Move WDT device definitions in plat-samsung
      ARM: SMDK6410: Add Watchdog support for SMDK6410
      ARM: S5P6440: Add Watchdog support for S5P6440
      ARM: S5PV210: Add Watchdog support for S5PV210

Ben Dooks (93):
      ARM: S3C24XX: Add initial s3c_gpio configuration code
      ARM: S3C24XX: Add the gpio pull configuration for pull-up
      ARM: S3C24XX: Add extended GPIO used on S3C2443 and beyond
      ARM: H1940: Change h1940-bluetooth to use gpiolib API
      ARM: JIVE: Update mach-jive to use gpiolib API
      ARM: H1940: Change mach-h1940 to use gpiolib API
      ARM: QT2410: Update mach-qt2410 to use gpiolib API
      ARM: n30: Update mach-n30 to use gpiolib API
      ARM: BAST: Update mach-bast to use gpiolib API
      ARM: VR1000: Update mach-vr1000.c to use gpiolib API
      ARM: S3C2410: Change s3c2410_gpio_pullupl(x, 1) to use s3c_gpio_cfgpull()
      ARM: S3C24XX: Change s3c2410_gpio_pullupl(x, 1) to use s3c_gpio_cfgpull()
      ARM: S3C24XX: Drop s3c2410 specific s3c2410_gpio_cfgpin()
      ARM: S3C24XX: Remove s3c2410_gpio_setcfg()
      ARM: S3C24XX: Remove s3c2410_gpio_getpull()
      ARM: S3C24XX: Remove s3c2410_gpio_getirq()
      ARM: SAMSUNG: Add GPIO configuration read calls
      ARM: S3C24XX: Remove s3c2410_gpio_getcfg(), implement s3c_gpio_getcfg()
      ARM: mini2440: Move to using gpiolib API and s3c_gpio functions
      ARM: S3C2410: Remove the users of s3c2410_gpio_pullup()
      ARM: S3C24XX: Wrapper s3c2410_gpio_setpin and s3c2410_gpio_pullup()
      ARM: S3C24XX: Remove S3C2410_GPJ numbering
      ARM: S3C24XX: Remove _INP macros in <mach/regs-gpioj.h>
      ARM: n30: Fixup gpiolib calls for mmc power
      ARM: n30: Just call s3c24xx_init_irq() directly from machine definition
      ARM: SAMSUNG: Move S3C6400 PLL code to <plat/pll.h> for re-use
      ARM: SAMSUNG: Add s3c_disable_clocks() and tidy init+disable usage
      ARM: S3C24XX: Identify S3C2416 if S3C2412/S3C2413 built in
      ARM: S3C2443: Move parts of the clock code to common clock file
      ARM: S3C2416: Add basic clock support
      ARM: S3C2416: Add support for second HSMMC channel
      ARM: S3C2416: Add support for OHCI on SMDK2416
      ARM: S3C2416: Use s3c2440 style i2c controller
      ARM: S3C2413: Update GPIO pull-up support
      ARM: SAMSUNG: Update S3C2416 entry with S3C2450
      ARM: SAMSUNG: Add spinlock locking to GPIO banks
      ARM: SAMSUNG: Remove old email address for ben-linux at fluff.org
      ARM: S3C2443: Add initial defines for framebuffer support
      ARM: S3C2443: Fix definition of LCD clock bit
      ARM: SAMSUNG: Set S3C_FB_MAX_WIN in <plat/fb.h>
      ARM: SMDK2416: Add support for framebuffer device and ensure correct setup
      ARM: S3C24XX: Start cleanup of GPIO numbering
      ARM: S3C24XX: Update missed gpio calls to use gpiolib
      ARM: S3C24XX: Remove macros mapping GPIO number to base
      ARM: S3C24XX: Add note on GPIO bank sizes
      ARM: SAMSUNG: Fix additional increment when running through gpios
      ARM: Merge for-2635/s3c24xx-general
      ARM: Merge for-2635/s5p-general
      ARM: Merge for-2635/samsung-dma
      ARM: Merge for-2635/samsung-hwmon
      ARM: Merge for-2635/samsung-clock
      ARM: Merge for-2635/acer-n35
      ARM: Merge for-2635/rx1950
      ARM: Merge for-2635/gpio2
      ARM: Merge for-2635/s3c6410-clock
      ARM: Merge for-2635/s5p6440-clock
      ARM: Merge for-2635/s5pv210-clock
      ARM: Merge for-2635/fb-updates1
      ARM: Merge for-2635/s5p-dma
      ARM: Merge for-2635/s5p-audio
      ARM: Merge for-2635/samsung-ts
      ARM: Merge for-2635/samsung-rtc
      ARM: SAMSUNG: Move s3c64xx dev-ts.c to plat-samsung and rename configuration
      Input: s3c24xx_ts - depend on SAMSUNG_DEV_TS and update menu entry
      ARM: S5PV210: Remove limiting choice of machine to build
      ARM: S5PV210: Fixup machine Kconfig order
      ARM: Merge for-2635-4/s5pc1xx-removal
      ARM: Merge for-2635-4/ts-machines
      ARM: Merge for-2635-4/s5pv210-boards
      ARM: Merge for-2635-4/s5p-devs
      ARM: Merge for-2635-4/spi-devs
      ARM: Merge for-2635-4/watchdog
      ARM: Merge for-2635-4/onenand
      ARM: SAMSUNG: Fixup convert arm to arch_gettimeoffset()
      ARM: SAMSUNG: Fixup merge problem
      ARM: S5PV210: Fixup ADC device change
      ARM: S5PV210: Add temporary <mach/regs-fb.h>
      ARM: S5P6440: Add locking to GPIO calls
      ARM: SAMSUNG: Make ADC client SMP safe
      ARM: SAMSUNG: Add support for interrupt wakeup-sources
      ARM: S3C64XX: PM: Synchronise wakeup mask on suspend
      ARM: S5PC100: Fix definition of IRQ_EINT()
      ARM: S5PC100: Fixup merge problems
      ARM: s5pc100_defconfig: change ARCH_S5PC1XX to ARCH_S5PC100
      ARM: s3c2410_defconfig: Update s3c2410_defconfig to v2.6.34
      ARM: s3c6400_defconfig: Update s3c6400_defconfig to v2.6.34
      ARM: s5p6440_defconfig: Update s5p6440_defconfig to v2.6.34
      ARM: s5p6442_defconfig: Update s5p6442_defconfig to v2.6.34
      ARM: s5pc110_defconfig: Update s5pc110_defconfig to v2.6.34
      ARM: s5pv210_defconfig: Update s5pv210_defconfig to v2.6.34
      ARM: s3c6400_defconfig: enable power management
      ARM: s3c6400_defconfig: enable sound as modules
      ARM: s3c6400_defconfig: Add NAND driver

Jassi Brar (23):
      ARM: S3C6410: Define clk_src2 register
      ARM: S3C6410: Declare IISCDCLK_V4 Clock
      ARM: S3C6410: Declare possible sources of audio-bus2
      ARM: S3C6410: Declare IISv4 audio-bus clock
      S3C: DMA: Change argument of s3c2410_dma_devconfig
      S3C: DMA: Add api driver for PL330
      S5P6440: DMA: Add platform devices for PL330 DMACs
      S5P6442: DMA: Add platform devices for PL330 DMACs
      S5PV210: DMA: Add platform devices for PL330 DMACs
      ARM: S5PV210: Add audio platform devices
      ARM: SMDKV210: Add audio devices on board
      ARM: SMDKC110: Add audio devices on board
      ARM: S5P6442: Add audio platform devices
      ARM: SMDK6442: Add audio devices on board
      ARM: S5P6440: Add audio platform devices
      ARM: SMDK6440: Add audio devices on board
      ARM: S5PC100: Add audio platform devices
      ARM: SMDKC100: Add audio devices on board
      ARM: S5PC100: Define SPI platform devices
      ARM: S5PV210: Define SPI platform devices
      ARM: S5P6442: Define SPI platform devices
      ARM: S5P6440: Define SPI platform devices
      ARM: S5PC100: DMA: Add platform devices for PL330 DMACs

Jongpill Lee (4):
      ARM: S5P6440: Bug fix on PWM Timer
      ARM: S5P6442: Bug fix on PWM Timer
      ARM: S5PV210: Bug fix on PWM Timer
      ARM: S5PV210: Add IRQ_EINT interrupt support.

Joonyoung Shim (1):
      ARM: S5PV210: Add GONI board support

Kukjin Kim (1):
      ARM: SAMSUNG: Remove static of S5P SoCs sysclass

Marek Szyprowski (22):
      ARM: SAMSUNGy: fix broken timer irq base
      ARM: SAMSUNG: move driver strength gpio configuration helper to common dir
      ARM: SAMSUNG: Copy common I2C0 device helpers to machine directories
      drivers: serial: S5PC100 serial driver cleanup
      ARM: S5PC100: Use common functions for gpiolib implementation
      ARM: S5PC100: Move gpio support from plat-s5pc1xx to mach-s5pc100
      ARM: S5PC100: gpio.h cleanup
      ARM: S5PC100: Move frame buffer helpers from plat-s5pc1xx to mach-s5pc100
      ARM: S5PC100: Move i2c helpers from plat-s5pc1xx to mach-s5pc100
      ARM: SMDKC100: fix frame buffer definitions
      ARM: SMDKC100: remove magic values from uart setup structures
      ARM: S5PV210: add Aquila board
      ARM: S5PV210: add support for s3c-fb driver on Aquila machine
      ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx to mach-s5pc100
      ARM: SAMSUNG: move S5PC100 support from plat-s5pc1xx to plat-s5p framework
      ARM: S5PC100: Add support for gpio interrupt
      ARM: S5PC100: use common plat-s5p external interrupt code
      ARM: remove obsolete plat-s5pc1xx directory
      ARM: SAMSUNG: Add platform support code for OneNAND controller
      ARM: S5PV210: add framebuffer platform helpers for s5pv210 based machines
      ARM: S5PV210: add common I2C device helpers
      ARM: S5PV210: add common HSMMC device helpers

Maurus Cuelenaere (5):
      ARM: SAMSUNG: Move HWMON from plat-s3c24xx to plat-samsung
      ARM: S3C64XX: Add USB external clock definition
      ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
      ARM: S3C64XX: Add touchscreen platform device definition
      ARM: S3C6410: Add basic support for SmartQ machines

Mike Solovyev (1):
      ARM: h1940: framebuffer configuration fix

Naveen Krishna (4):
      ARM: SAMSUNG: Moving ADC device definition to plat-samsung.
      ARM: SAMSUNG: Implements cfg_gpio function for Samsung touchscreen
      Input: s3c24xx_ts - Implement generic GPIO configuration callback
      Input: s3c24xx_ts - Add FEAT for Samsung touchscreen support

Naveen Krishna Ch (3):
      ARM: S3C64XX: Add Touchscreen support for S3C64XX
      ARM: S5P6440: Add Touchscreen support for S5P6440
      ARM: S5PV210: Add Touchscreen support for S5PV210

Pannaga Bhushan (1):
      ARM: S5PV210: Add GPIOlib support

Pinkava J (8):
      ARM: n30: Enable Acer n35 if Acer n30 is selected
      ARM: n30: fix: suspended wrong USB port on Acer n35
      ARM: n30: Add RTC platform device for Acer n30 / Acer n35
      ARM: n35: Add support for LEDs on Acer n35
      ARM: n35: Enable wake-up by Power button on Acer n35
      ARM: n30: Add support for MMC card reader on Acer n30 / Acer n35
      ARM: n30: Add support for power on/off on Acer n30 / Acer n35 MMC card reader
      ARM: SAMSUNG: fix suspend/resume on if some GPIO banks not present

Thomas Abraham (28):
      ARM: S5P: Add USB External Crystal clock definition
      ARM: S5P6440: Register apll/mpll/epll mout clocks.
      ARM: S5P6440: Change dout_mpll clock type to clksrc_clk clock type.
      ARM: S5P6440: Remove usage of clk_arm and add clk_armclk clock
      ARM: S5P6440: Remove usage of clk_h and add clk_hclk clock
      ARM: S5P6440: Remove usage of clk_p and add clk_pclk clock
      ARM: S5P6440: Remove usage of clk_h_low and add clk_hclk_low clock
      ARM: S5P6440: Remove usage of clk_p_low and add clk_pclk_low clock
      ARM: S5P6440: Add clocks of type 'struct clk'.
      ARM: S5P6440: Rename clkset_mmc_spi to clkset_group1
      ARM: S5P6440: Add clocks of type 'struct clksrc_clk'.
      ARM: S5PV210: Rearrange the system clock definitions
      ARM: S5PV210: Register apll/mpll/epll clksrc_clk clocks
      ARM: S5PV210: Rearrange assignment of clock for fout apll/mpll/epll clocks
      ARM: S5PV210: Add armclk of clksrc_clk clock type
      ARM: S5PV210: Remove usage of clk_h200 clock and add clk_hclk_msys clock
      ARM: S5PV210: Remove usage of clk_h166 and add clk_hclk_dsys clock
      ARM: S5PV210: Remove usage of clk_h133 and add clk_hclk_psys clock
      ARM: S5PV210: Remove usage of clk_p100 and add clk_pclk_msys clock
      ARM: S5PV210: Fix clk_get_rate issue with the clk_h100 clock
      ARM: S5PV210: Remove usage of clk_p83 and add clk_pclk_dsys clock\
      ARM: S5PV210: Remove usage of clk_p66 and add clk_pclk_psys clock
      ARM: S5PV210: Add support for VPLL
      ARM: S5PV210: Add new system clocks
      ARM: S5PV210: Add sclk_dac, sclk_mixer and sclk_hdmi clocks
      ARM: S5PV210: Add sclk_audio and sclk_spdif clocks.
      ARM: S5PV210: Add sclk clocks of type 'struct clksrc_clk' clock
      ARM: S5PC100: Pre-requisite clock patch for plat-s5pc1xx to plat-s5p move

Vasily Khoruzhick (5):
      ARM: S3C2440: Add HP iPAQ RX1950 machine support
      ARM: S3C24XX: Locate kernel at 0x30108000 if PM_H1940 is enabled
      ARM: RX1950: Add suspend/resume support for RX1950
      ARM: RX1950: configure GPG13-15 as input before suspend
      ARM: S3C244X: fix gpiolib port J support

Yauhen Kharuzhy (5):
      ARM: S3C: Add S3C2416 detection to uncompress code
      serial: Use s3c2440 driver for S3C2416 SoC
      ARM: S3C2416: Add S3C2416-specific registers definitions
      ARM: S3C2416: Add arch support
      ARM: S3C2416: Add initial support of SMDK2416




-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
