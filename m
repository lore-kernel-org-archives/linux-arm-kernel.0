From: michael.weiser@gmx.de (Michael Weiser)
Date: Fri, 22 Jul 2016 15:56:58 +0200
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <20160722090101.GB7687@lukather>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-4-michael.weiser@gmx.de>
 <20160722090101.GB7687@lukather>
Message-ID: <20160722135658.GA18977@weiser.dinsnail.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, Jul 22, 2016 at 11:01:01AM +0200, Maxime Ripard wrote:

> > At least the Cubieboard2 incarnation of sunxi works correctly in
> > big-endian mode. Allow the selection of big-endian.
> With what devices has it been tested? The one doing DMA will probably
> be the one who fail, have you tested the DMA engine? EMAC? GMAC?

I've tested with a Cubieboard2 Two-Card (on-board EMMC replaced with a
second slot). I ran into and fixed DMA problems with stmmac (that's
GMAC) and sunxi-mmc. Patches are submitted as part of this patchset.
Endianness fixes to stmmac went much farther than just GMAC but remain
untested since the Cubieboard2 only uses GMAC.

I have also successfully used SATA, SPI, UART, security system (with
cryptodev), the hwmon part of the touchscreen controller, pinctrl with a
custom interrupt pin via fdt for ethernet via SPI (ENC28J60), watchdog
as reset controller, onboard RTC and external battery-backed DS1307 RTC
via I2C. I have not deliberately/synthetically tested the DMA engine. It's
enabled in the my kernel config and seems happy but was not selected by
any other driver so seems to be unused currently.

I was reluctant to enable big endian support this generically but found
no better way. Since board specifics are in device tree now, I can't
really do a && CONFIG_MACH_CUBIEBOARD2 or somesuch. Or can I?
-- 
Thanks,
Michael
