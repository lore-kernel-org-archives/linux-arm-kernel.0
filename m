From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 02:03:18 +0000
Subject: Updated next-samsung available
Message-ID: <20100125020318.GQ10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merged the next-samsung-fixes-25jan2010 into next-samsung and updated
git.fluff.org with it.

The current state from for-rmk/samsung is:

Ben Dooks (6):
      ARM: SAMSUNG: Move more support into plat-samsung
      ARM: SAMSUNG: Move pmw.c to plat-samsung
      ARM: SAMSUNG: Move pm-check.c to plat-samsung
      ARM: S3C64XX: Tidy up common code in s3c64xx_spi_set_info()
      ARM: S5P6440: Add HSMMC and OTG base addresses to map.h
      ARM: SAMSUNG: Fix bad use of __initdata for s3c_register_clocks()

Kukjin Kim (1):
      ARM: S5P: Move Timer support

Mark Brown (4):
      ARM: SMDK6410: Set up interrupt range for WM835x on 1190-EV1 PMIC board
      ARM: S3C64XX: Fix dev-audio build
      ARM: S3C64XX: Staticise audio platform data
      ARM: SAMSUNG: Staticise gpiolib implementation functions

Maurus Cuelenaere (2):
      ARM: S3C64XX: Fix typo in s3c-hsotg platform data
      ARM: SAMSUNG: Fix null pointer dereference in ADC driver

Thomas Abraham (1):
      ARM: S5PV210: Add serial port support

The state from the latest kernel release is:

Andy Green (4):
      ARM: S3C64XX: Add SROM register definitions
      ARM: SMDK6410: Add nC1 chipselect SROM setup
      ARM: S3C64XX: Add virtual mapping for S3C64XX SROM area
      ARM: SMDK6410: Add comments on ethernet connectivity

Ben Dooks (56):
      ARM: MINI2440: Fixup __initdata usage
      ARM: SAMSUNG: Move <plat/clock.h> to plat-samsung
      ARM: S3C64XX: Cleanup common init code in s3c6400-clock.c
      ARM: S3C64XX: Compress s3c6400-clock.c code
      ARM: S3C64XX: Use new clock-clksrc.c code for clocks.
      ARM: SAMSUNG: Reduce size of struct clk.
      ARM: S3C64XX: Fixup .reg_src and .reg_div with named initialisers
      ARM: S3C64XX: Avoid announcing clksrc clocks twice
      ARM: SAMSUNG: Move clock.c to arch/arm/plat-samsung
      ARM: SAMSUNG: Do not allow get/set/round rate calls with no divider
      ARM: SAMSUNG: Add call to register array of clocks
      ARM: SAMSUNG: Do not register set_parent call if no source
      ARM: SAMSUNG: Move pwm-clock code into plat-samsung
      ARM: SAMSUNG: Move device definitions in plat-samsung
      ARM: SAMSUNG: Move gpio-config.c into plat-samsung
      ARM: SAMSUNG: Move IRQ VIC timer handling out to common header files
      ARM: SAMSUNG: Move IRQ UART handling for newer devices to plat-samsung
      ARM: Add common entry code for system with two VICs
      ARM: S5PC1XX: Move to using generic clksrc_clk for clock code
      ARM: S5PC1XX: Move clock definitions around ready to turn into clksrc arrays
      ARM: S5PC1XX: Change clksrc_clks to use array of clocks
      ARM: SAMSUNG: Add script to change old clksrc_clk to new register defs
      ARM: S5PC1XX: Remove definitions deleted by previous clksrc changes
      ARM: S5PC1XX: Move to using standard timer IRQ handling code
      ARM: S5PC1XX: Use common UART IRQ handling code
      ARM: S3C: Rename s3c_device_usb to s3c_device_ohci
      ARM: S3C2412: Fixup commented out device in SMDK2413
      ARM: Merge next-s3c64xx
      ARM: S5PC1XX: Register pd0 and hd0 clocks, remove unecessary dummy_enable
      ARM: SAMSUNG: Fix clksrc-clk's checks for bad register settings
      ARM: SAMSUNG: Fix bug in clksrc-clk round_rate call.
      ARM: SAMSUNG: Make UART device code common
      ARM: SAMSUNG: Add platform data registration for OHCI
      ARM: MINI2440: Remove commented out devices from device array
      ARM: S3C24XX: Add mci platform data set call s3c24xx_mci_set_platdata().
      ARM: Merge next-samsung-mc-adc
      ARM: Merge next-s3c6410-andygreen
      ARM: Merge next-jassi-spi
      ARM: Merge next-samsung-devupdates1
      ARM: Merge next-samsung-clock2
      ARM: Merge next-jassi-spi
      ARM: Merge next-samsung-devupdates1
      ARM: Merge next-samsung-clock2
      ARM: Merge next-samsung-serial1
      ARM: SAMSUNG: Move pm-gpio into plat-samsung
      ARM: SAMSUNG: Move gpiolib support in gpio.c to plat-samsung
      ARM: SAMSUNG: Move GPIO headers to plat-samsung
      ARM: SAMSUNG: Remove empty gpio-core.h and use central plat/gpio-core.h
      ARM: SAMSUNG: Add initial documentation directory and overview
      ARM: Merge next-samsung-s5p6440-iodec
      ARM: SAMSUNG: Move more support into plat-samsung
      ARM: SAMSUNG: Move pmw.c to plat-samsung
      ARM: SAMSUNG: Move pm-check.c to plat-samsung
      ARM: S3C64XX: Tidy up common code in s3c64xx_spi_set_info()
      ARM: S5P6440: Add HSMMC and OTG base addresses to map.h
      ARM: SAMSUNG: Fix bad use of __initdata for s3c_register_clocks()

Harald Welte (2):
      ARM: SAMSUNG: Add core clock implementation for clksrc based clocks
      ARM: S3C64XX: Remove unused clock definitions from clock header

Jassi Brar (5):
      ARM: S3C64XX: Add I2S resources in platform code
      ARM: S3C64XX: SPI: Add SPI controller register base
      ARM: S3C64XX: SPI: Define SPI-48M clock sources
      ARM: S3C64XX: SPI: Header for passing platform data
      ARM: S3C64XX: SPI: Define SPI controller devices

Kukjin Kim (14):
      ARM: SAMSUNG: Make clk_default_setrate and clk_ops_def_setrate visible
      ARM: SAMSUNG: Add config option for number of additional GPIO pins.
      ARM: S5P6440: Add new CPU initialization support
      ARM: S5P6440: Add Clock and PLL support
      ARM: S5P6440: Add IRQ support
      ARM: S5P6440: Add Timer support
      ARM: S5P6440: Add new Kconfig and Makefiles
      ARM: S5P6440: Add Board support file
      ARM: S5P6440: Add configuration file
      ARM: S5P6440: Add serial port support
      ARM: SAMSUNG: Move GPIO common functions to plat-samsung
      ARM: S5P6440: Add S5P6440 GPIO support
      ARM: S5P6440: Add IO descriptor for ChipID block.
      ARM: S5P: Move Timer support

Mark Brown (5):
      ARM: SMDK6410: Specify no GPIO for B_PWR_5V regulator
      ARM: SMDK6410: Set up interrupt range for WM835x on 1190-EV1 PMIC board
      ARM: S3C64XX: Fix dev-audio build
      ARM: S3C64XX: Staticise audio platform data
      ARM: SAMSUNG: Staticise gpiolib implementation functions

Maurus Cuelenaere (5):
      ARM: S3C64XX: Add S3C64XX RTC platform driver
      ARM: SAMSUNG: Move S3C24XX ADC driver to plat-samsung
      ARM: S3C64XX: Add S3C64XX support to the generic Samsung ADC driver
      ARM: S3C64XX: Fix typo in s3c-hsotg platform data
      ARM: SAMSUNG: Fix null pointer dereference in ADC driver

Ramax Lo (1):
      ARM: S3C: NAND: Check the existence of nr_map before copying

Thomas Abraham (3):
      ARM: SAMSUNG: Add check to ensure that clksrc_clk does have multiple clock sources
      ARM: SAMSUNG: serial: Modify console initialization.
      ARM: S5PV210: Add serial port support

Uri Yosef (1):
      ARM: MINI2440: Fix crash on boot due to improper __initdata qualifier

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
