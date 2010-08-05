From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 5 Aug 2010 15:44:49 +0800
Subject: [GIT PULL] pxa patches for v2.6.36 merge window
Message-ID: <AANLkTi=TV_dZEb-DxhPL6BQGEX7RkP6FRC6XV_iEBusJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please consider pulling, there'll be a merge conflict with palmtreo.c and
palmt5.c, which is fairly straight-forward to solve. I've yet attached my
merge commit diff.

The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Christoph Egger (6):
      [ARM] pxa: replacing dead SHARPSL_LOCOMO with SHARP_LOCOMO
      [ARM] pxa: removing dead BACKLIGHT_CORGI
      [ARM] pxa: removing dead ARCH_GUMSTIX_ORIG
      [ARM] pxa: removing dead CORGI_SSP_DEPRECATED
      [ARM] pxa: removing dead XSCALE_CACHE_ERRATA
      [ARM] pxa: removing dead IDE_PXA_CF

Daniel Mack (2):
      [ARM] pxa/colibri270: Split module and base board code
      [ARM] pxa/raumfeld: Check charge state after resume

Eric Miao (15):
      [ARM] pxa/corgi: fix MMC/SD card detection failure
      [ARM] pxa: move pmu device back into mach-pxa/
      [ARM] pxa: merge all eseries board code into eseries.c
      [ARM] pxa: remove now unnecessary dma_needs_bounce()
      [ARM] pxa: move hidden Kconfig options to right place and vice versa
      [ARM] pxa: PXA_SHARPSL_DETECT_MACH_ID to include head-sharpsl.S
      [ARM] pxa/spitz: remove unused declarations
      [ARM] pxa/corgi: remove unused declarations of corgiscoop_device
      [ARM] pxa: use generic gpio_get_value() instead of READ_GPIO_BIT()
      [ARM] pxa: removed mostly unused and confusing two sharpsl.h
      [ARM] mmp: remove never supported .boot_params for MMP
      [ARM] mmp: rename pxa_map_io() to mmp_map_io()
      [ARM] mmp: move mmp2 specific timer code to mmp2.c
      [ARM] mmp: avoid devices.h being included multiple times
      [ARM] mmp: move declarations into SoC specific header file from common.h

Igor Grinberg (3):
      [ARM] pxa: add set_type to the pxa3xx ext_wakeup irq chip.
      [ARM] pxa/cm-x300: enable the IRQ_WAKEUP0 as wakeup source.
      [ARM] pxa/cm-x300: fix ffuart registration

Jonathan Cameron (2):
      [ARM] mmp: fix build failure due to IRQ_PMU depends on ARCH_PXA
      [ARM] pxa: merge stargate2 and imote2 board files

Marek Vasut (32):
      [ARM] pxa/z2: fix missing include in battery driver
      [ARM] pxa/z2: fix flash layout to final version
      [ARM] pata_pxa: DMA-capable PATA driver
      [ARM] pxa/vpac270: Convert to use PATA PXA driver
      [ARM] pxa/vpac270: Add PMIC support
      [ARM] pxa/vpac270: Add VGA modes for ADV7125
      [ARM] pxa/colibri270: Refactor board definition file
      [ARM] pxa/colibri270: Add MMC support
      [ARM] pxa/colibri270: Add FFUART MFP
      [ARM] pxa/colibri270: Add UHC support
      [ARM] pxa/colibri270: Add TSC support
      [ARM] pxa/income: Add Income SBC support
      [ARM] pxa/z2: Add battery support into Zipit Z2
      [ARM] pxa/z2: Register WM8750
      [ARM] pxa: fix all devices using wm97xx_batt.h
      [ARM] wm97xx_batt: remove now useless header file
      [ARM] pxa/z2: Add regulator support
      [ARM] pxa/colibri320: Add UDC support
      [ARM] scoop: Add CPR register bit definitions
      [ARM] pxa: fix HSIO bus x24 multiplier for pxa3xx
      [ARM] pxa: cpufreq-pxa2xx: fix DRI recomputation routine
      [ARM] pxa/palm: Introduce Palm27x
      [ARM] pxa/palm: Flip Palm LD,TX,T5,Z72 to Palm27x
      [ARM] pxa/spitz: Rework spitz
      [ARM] pxa/spitz: Formating and naming fixes
      [ARM] pxa/z2: Fix flash layout typo
      [ARM] pxa/balloon3: Machine file cleanup
      [ARM] pxa/balloon3: Machine file cleanup
      [ARM] pxa/balloon3: PCMCIA Support
      [ARM] pxa/balloon3: PCF857x GPIO expander and LEDs
      [ARM] pxa/balloon3: Add NAND driver
      [ARM] pxa/balloon3: Add MAX1586 PMIC support

Robert Jarzmik (1):
      [ARM] pxa/mioa701: fix camera regression

Steve Bennett (1):
      [ARM] pxa: fix incorrect gpio type in udc_pxa2xx.h

 MAINTAINERS                                  |    7 +
 arch/arm/boot/compressed/Makefile            |    2 +-
 arch/arm/common/it8152.c                     |    8 -
 arch/arm/include/asm/dma-mapping.h           |    8 +
 arch/arm/include/asm/hardware/scoop.h        |   29 +-
 arch/arm/include/asm/mach/udc_pxa2xx.h       |    4 +-
 arch/arm/mach-mmp/aspenite.c                 |    6 +-
 arch/arm/mach-mmp/avengers_lite.c            |    3 +-
 arch/arm/mach-mmp/common.c                   |    2 +-
 arch/arm/mach-mmp/common.h                   |   11 +-
 arch/arm/mach-mmp/flint.c                    |    3 +-
 arch/arm/mach-mmp/include/mach/devices.h     |    4 +
 arch/arm/mach-mmp/include/mach/mmp2.h        |    7 +
 arch/arm/mach-mmp/include/mach/pxa168.h      |    5 +
 arch/arm/mach-mmp/include/mach/pxa910.h      |    5 +
 arch/arm/mach-mmp/irq-mmp2.c                 |    1 +
 arch/arm/mach-mmp/jasper.c                   |    3 +-
 arch/arm/mach-mmp/mmp2.c                     |   22 +
 arch/arm/mach-mmp/tavorevb.c                 |    3 +-
 arch/arm/mach-mmp/time.c                     |   21 -
 arch/arm/mach-mmp/ttc_dkb.c                  |    3 +-
 arch/arm/mach-pxa/Kconfig                    |   80 ++-
 arch/arm/mach-pxa/Makefile                   |   13 +-
 arch/arm/mach-pxa/balloon3.c                 |  732 ++++++++++++++++++-----
 arch/arm/mach-pxa/cm-x300.c                  |    4 +-
 arch/arm/mach-pxa/colibri-pxa270-evalboard.c |  111 ++++
 arch/arm/mach-pxa/colibri-pxa270-income.c    |  272 +++++++++
 arch/arm/mach-pxa/colibri-pxa270.c           |  176 ++++--
 arch/arm/mach-pxa/colibri-pxa320.c           |   40 ++
 arch/arm/mach-pxa/corgi.c                    |    7 +-
 arch/arm/mach-pxa/corgi_pm.c                 |   11 +-
 arch/arm/mach-pxa/cpufreq-pxa2xx.c           |    8 +-
 arch/arm/mach-pxa/devices.c                  |   14 +
 arch/arm/mach-pxa/devices.h                  |    1 +
 arch/arm/mach-pxa/e330.c                     |   78 ---
 arch/arm/mach-pxa/e350.c                     |   79 ---
 arch/arm/mach-pxa/e400.c                     |  155 -----
 arch/arm/mach-pxa/e740.c                     |  225 -------
 arch/arm/mach-pxa/e750.c                     |  226 -------
 arch/arm/mach-pxa/e800.c                     |  229 --------
 arch/arm/mach-pxa/eseries.c                  |  809 ++++++++++++++++++++++++++
 arch/arm/mach-pxa/imote2.c                   |  590 -------------------
 arch/arm/mach-pxa/include/mach/balloon3.h    |   75 ++-
 arch/arm/mach-pxa/include/mach/colibri.h     |   32 +-
 arch/arm/mach-pxa/include/mach/corgi.h       |    5 -
 arch/arm/mach-pxa/include/mach/gumstix.h     |   12 +-
 arch/arm/mach-pxa/include/mach/palm27x.h     |   81 +++
 arch/arm/mach-pxa/include/mach/pata_pxa.h    |   33 +
 arch/arm/mach-pxa/include/mach/sharpsl.h     |   35 --
 arch/arm/mach-pxa/include/mach/sharpsl_pm.h  |    9 +
 arch/arm/mach-pxa/include/mach/spitz.h       |    2 -
 arch/arm/mach-pxa/mioa701.c                  |   12 +-
 arch/arm/mach-pxa/palm27x.c                  |  477 +++++++++++++++
 arch/arm/mach-pxa/palmld.c                   |  292 ++--------
 arch/arm/mach-pxa/palmt5.c                   |  283 +--------
 arch/arm/mach-pxa/palmte2.c                  |   20 +-
 arch/arm/mach-pxa/palmtreo.c                 |  354 ++----------
 arch/arm/mach-pxa/palmtx.c                   |  299 ++--------
 arch/arm/mach-pxa/palmz72.c                  |  264 +--------
 arch/arm/mach-pxa/poodle.c                   |    2 -
 arch/arm/mach-pxa/pxa25x.c                   |    1 +
 arch/arm/mach-pxa/pxa27x.c                   |    1 +
 arch/arm/mach-pxa/pxa3xx.c                   |   15 +-
 arch/arm/mach-pxa/raumfeld.c                 |   29 +-
 arch/arm/mach-pxa/sharpsl.h                  |   26 -
 arch/arm/mach-pxa/sharpsl_pm.c               |   23 -
 arch/arm/mach-pxa/sleep.S                    |    7 -
 arch/arm/mach-pxa/spitz.c                    |  727 ++++++++++++++----------
 arch/arm/mach-pxa/spitz_pm.c                 |   11 +-
 arch/arm/mach-pxa/stargate2.c                |  679 ++++++++++++++-------
 arch/arm/mach-pxa/trizeps4.c                 |    6 +-
 arch/arm/mach-pxa/vpac270.c                  |  126 ++++-
 arch/arm/mach-pxa/z2.c                       |  142 ++++-
 arch/arm/mach-sa1100/include/mach/irqs.h     |    2 +-
 arch/arm/plat-pxa/Makefile                   |    2 +-
 arch/arm/plat-pxa/pmu.c                      |   33 -
 drivers/ata/Kconfig                          |   11 +
 drivers/ata/Makefile                         |    2 +
 drivers/ata/pata_pxa.c                       |  411 +++++++++++++
 drivers/pcmcia/Kconfig                       |    2 +-
 drivers/pcmcia/Makefile                      |    1 +
 drivers/pcmcia/pxa2xx_balloon3.c             |  158 +++++
 drivers/power/wm97xx_battery.c               |   16 -
 drivers/power/z2_battery.c                   |   12 +-
 include/linux/wm97xx_batt.h                  |   16 -
 85 files changed, 4780 insertions(+), 3983 deletions(-)
 create mode 100644 arch/arm/mach-pxa/colibri-pxa270-evalboard.c
 create mode 100644 arch/arm/mach-pxa/colibri-pxa270-income.c
 delete mode 100644 arch/arm/mach-pxa/e330.c
 delete mode 100644 arch/arm/mach-pxa/e350.c
 delete mode 100644 arch/arm/mach-pxa/e400.c
 delete mode 100644 arch/arm/mach-pxa/e740.c
 delete mode 100644 arch/arm/mach-pxa/e750.c
 delete mode 100644 arch/arm/mach-pxa/e800.c
 delete mode 100644 arch/arm/mach-pxa/imote2.c
 create mode 100644 arch/arm/mach-pxa/include/mach/palm27x.h
 create mode 100644 arch/arm/mach-pxa/include/mach/pata_pxa.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/sharpsl.h
 create mode 100644 arch/arm/mach-pxa/palm27x.c
 delete mode 100644 arch/arm/mach-pxa/sharpsl.h
 delete mode 100644 arch/arm/plat-pxa/pmu.c
 create mode 100644 drivers/ata/pata_pxa.c
 create mode 100644 drivers/pcmcia/pxa2xx_balloon3.c
 delete mode 100644 include/linux/wm97xx_batt.h
-------------- next part --------------
diff --cc arch/arm/mach-pxa/palmt5.c
index 5e92d84,731ee7b..1c28199
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@@ -378,30 -172,6 +173,11 @@@ static inline void palmt5_keys_init(voi
  /******************************************************************************
   * Machine init
   ******************************************************************************/
- static struct platform_device *devices[] __initdata = {
- #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
- 	&palmt5_pxa_keys,
- #endif
- 	&palmt5_backlight,
- 	&power_supply,
- 	&palmt5_asoc,
- 	&palmt5_gpio_vbus,
- };
- 
- /* setup udc GPIOs initial state */
- static void __init palmt5_udc_init(void)
- {
- 	if (!gpio_request(GPIO_NR_PALMT5_USB_PULLUP, "UDC Vbus")) {
- 		gpio_direction_output(GPIO_NR_PALMT5_USB_PULLUP, 1);
- 		gpio_free(GPIO_NR_PALMT5_USB_PULLUP);
- 	}
- }
- 
 +static void __init palmt5_reserve(void)
 +{
 +	memblock_reserve(0xa0200000, 0x1000);
 +}
 +
  static void __init palmt5_init(void)
  {
  	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmt5_pin_config));
diff --cc arch/arm/mach-pxa/palmtreo.c
index 3d0c9cc,da592dc..f0b37e6
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@@ -588,60 -398,9 +399,15 @@@ static inline void palmtreo_leds_init(v
  /******************************************************************************
   * Machine init
   ******************************************************************************/
- static struct platform_device *treo_devices[] __initdata = {
- 	&treo_backlight,
- 	&power_supply,
- };
- 
- #ifdef CONFIG_MACH_TREO680
- static struct platform_device *treo680_devices[] __initdata = {
- 	&treo680_leds,
- };
- #endif /* CONFIG_MACH_TREO680 */
- 
- #ifdef CONFIG_MACH_CENTRO
- static struct platform_device *centro_devices[] __initdata = {
- 	&centro_leds,
- };
- #endif /* CONFIG_MACH_CENTRO */
- 
- /* setup udc GPIOs initial state */
- static void __init treo_udc_init(void)
- {
- 	if (!gpio_request(GPIO_NR_TREO_USB_PULLUP, "UDC Vbus")) {
- 		gpio_direction_output(GPIO_NR_TREO_USB_PULLUP, 1);
- 		gpio_free(GPIO_NR_TREO_USB_PULLUP);
- 	}
- }
- 
- static void __init treo_lcd_power_init(void)
- {
- 	int ret;
- 
- 	ret = gpio_request(GPIO_NR_TREO_LCD_POWER, "LCD POWER");
- 	if (ret) {
- 		pr_err("Treo680: LCD power GPIO request failed!\n");
- 		return;
- 	}
- 
- 	ret = gpio_direction_output(GPIO_NR_TREO_LCD_POWER, 0);
- 	if (ret) {
- 		pr_err("Treo680: setting LCD power GPIO direction failed!\n");
- 		gpio_free(GPIO_NR_TREO_LCD_POWER);
- 		return;
- 	}
- 
- 	treo_lcd_screen.pxafb_lcd_power = treo_lcd_power;
- }
- 
 +static void __init treo_reserve(void)
 +{
 +	memblock_reserve(0xa0000000, 0x1000);
 +	memblock_reserve(0xa2000000, 0x1000);
 +}
 +
- static void __init treo_init(void)
+ static void __init palmphone_common_init(void)
  {
+ 	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
  	pxa_set_ffuart_info(NULL);
  	pxa_set_btuart_info(NULL);
  	pxa_set_stuart_info(NULL);
@@@ -699,9 -448,7 +456,8 @@@ MACHINE_START(CENTRO, "Palm Centro 685"
  	.io_pg_offst    = io_p2v(0x40000000),
  	.boot_params    = 0xa0000100,
  	.map_io         = pxa_map_io,
 +	.reserve	= treo_reserve,
  	.init_irq       = pxa27x_init_irq,
  	.timer          = &pxa_timer,
-        .init_machine   = centro_init,
+        .init_machine	= centro_init,
  MACHINE_END
- #endif /* CONFIG_MACH_CENTRO */
