From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 May 2011 11:33:23 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <20110514221445.GB21792@opensource.wolfsonmicro.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105142233.53659.arnd@arndb.de>
	<20110514221445.GB21792@opensource.wolfsonmicro.com>
Message-ID: <201105151133.23870.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 May 2011, Mark Brown wrote:
> > My whole point has been that you register them from the main pruss driver
> > based on run-time data instead of compile-time pre-configured stuff in the
> > board file.
> 
> I'm not so sure - if the usage is fixed as a result of the pins on the
> device being wired a CAN bus then it seems reasonable to tell the system
> about that so it'll stop the user trying to run SPI or something against
> it at runtime.

I'm mostly worried about the case where the pins are not hardwired for
some specific function -- Subhasish was mentioning that these may be
implemented using a pluggable extension board and I want to make sure
that you are not required to recompile the kernel when changing the
extension board.

However, you made a good point that in many cases it will be hardwired
so it may be valuable to preconfigure this in a way that does not require
scripts to set up variables in sysfs when you already know what is there.

Note that my suggestion to put the device name into the firmware file
covers this case, because you can then simply ship a firmware blob that
matches the hardware configuration. Thinking about the future device
tree setup, you can even put the firmware blob itself into a property
in the device tree file.

	Arnd
