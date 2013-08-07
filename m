From: galak@kernel.crashing.org (Kumar Gala)
Date: Wed, 7 Aug 2013 10:40:24 -0500
Subject: [PATCH v4 00/31] add COMMON_CLK support for PowerPC MPC512x
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <BF555A06-59CD-4697-927E-04657E6F1DB1@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 6, 2013, at 3:43 PM, Gerhard Sittig wrote:

> this series
> - fixes several drivers that are used in the MPC512x platform (UART,
> SPI, ethernet, PCI, USB, CAN, NAND flash, video capture) in how they
> handle clocks (appropriately acquire and setup them, hold references
> during use, release clocks after use)
> - introduces support for the common clock framework (CCF, COMMON_CLK
> Kconfig option) in the PowerPC based MPC512x platform, which brings
> device tree based clock lookup as well
> 
> although the series does touch several subsystems -- tty (serial), spi,
> net (can, fs_enet), mtd (nfc), usb, i2c, media (viu), and dts -- all of
> the patches are strictly clock related or trivial
> 
> it appears most appropriate to take this series through either the clk
> or the powerpc trees after it has passed review and other subsystem
> maintainers ACKed the clock setup related driver modifications
> 
> the series passes 'checkpatch.pl --strict' except for one warning which
> cannot get resolved, since that either breaks compilation (the data type
> is preset by the clk-provider.h API) or requires a cast which shadows
> real mismatches:
> 
> WARNING: static const char * array should probably be static const char * const
> #431: FILE: arch/powerpc/platforms/512x/clock-commonclk.c:334:
> +static const char *parent_names_mux0[] = {
> 
> total: 0 errors, 1 warnings, 0 checks, 807 lines checked
> 
> each step in the series was build and run tested (with a display that is
> attached to the DIU as well as SPI, with an SPI attached NOR flash, with
> multiple UART ports such that one is not the boot console, with EEPROMs
> attached to I2C, with an SD card, booting from network)
> 

How do the driver changes impact other PPC SoCs that use the same drivers (i2c, fs_enet, usb) ?

- k
