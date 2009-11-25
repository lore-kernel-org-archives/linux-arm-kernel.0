From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:14 +0100
Subject: ARM: pxa: add support for Raumfeld audio devices
Message-ID: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a series of 17 patches to support the multiroom audio devices
produced and sold by Raumfeld. The kernel is based on mainline, and all
other pieces needed by these devices have already been submitted over
the last months.

What was still missing is the board support code which I would like to
let it life in the mainline git, too. The series is based on top of
Eric's pxa-devel tree.

For more information about the hardware, see http://www.raumfeld.com/en/

If that's still possible, I'd be happy if they could make it to 2.6.33.

Please note that one patch depends on the MAX8660 power regulator driver
which I cherry-picked in my tree. As there's need for a special include
file, I don't know what the best way would be to avoid build breakage.
Maybe queue it for 2.6.33-rc2, after the regulator tree has been merged?

Daniel

[PATCH 01/17] ARM: pxa/raumfeld: add basic structure for devices
[PATCH 02/17] ARM: pxa/raumfeld: add GPIO definitions
[PATCH 03/17] ARM: pxa/raumfeld: add SMSC9220 ethernet support
[PATCH 04/17] ARM: pxa/raumfeld: add OHCI function
[PATCH 05/17] ARM: pxa/raumfeld: add rotary encoder support
[PATCH 06/17] ARM: pxa/raumfeld: add GPIO buttons
[PATCH 07/17] ARM: pxa/raumfeld: add GPIO connected LEDs
[PATCH 08/17] ARM: pxa/raumfeld: add one-wire function
[PATCH 09/17] ARM: pxa/raumfeld: add NAND partitions
[PATCH 10/17] ARM: pxa/raumfeld: add framebuffer and backlight devices
[PATCH 11/17] ARM: pxa/raumfeld: add SPI controlled devices
[PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
[PATCH 13/17] ARM: pxa/raumfeld: add Marvell Libertas via SDIO
[PATCH 14/17] ARM: pxa/raumfeld: add power supply framework
[PATCH 15/17] ARM: pxa/raumfeld: add support for I2C controlled devices
[PATCH 16/17] ALSA: ARM: add Raumfeld audio support
[PATCH 17/17] ARM: pxa/raumfeld: Add defconfig
