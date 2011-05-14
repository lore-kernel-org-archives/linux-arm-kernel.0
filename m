From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 14 May 2011 15:14:46 -0700
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201105142233.53659.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<EAA964D5CCD94B4A9544B294E0CF5099@subhasishg>
	<20110514160126.GA2791@opensource.wolfsonmicro.com>
	<201105142233.53659.arnd@arndb.de>
Message-ID: <20110514221445.GB21792@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2011 at 10:33:53PM +0200, Arnd Bergmann wrote:

> I guess drivers/mfd would be a better place than drivers/misc, but it might not
> need to be an mfd driver in the sense that it registers mfd cells.

Yes, it might be more sensible to just open code.  OTOH mfd_cell is
marginally easier to use.

> The more important point is to remove the device registration from the board
> file. You definitely should not have the cells in the board file, but replacing
> them with platform devices in the board file makes it no better.

Agreed entirely, it should be something higher level than that.

> My whole point has been that you register them from the main pruss driver
> based on run-time data instead of compile-time pre-configured stuff in the
> board file.

I'm not so sure - if the usage is fixed as a result of the pins on the
device being wired a CAN bus then it seems reasonable to tell the system
about that so it'll stop the user trying to run SPI or something against
it at runtime.
