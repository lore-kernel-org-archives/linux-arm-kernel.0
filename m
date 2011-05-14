From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 May 2011 22:33:53 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <20110514160126.GA2791@opensource.wolfsonmicro.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<EAA964D5CCD94B4A9544B294E0CF5099@subhasishg>
	<20110514160126.GA2791@opensource.wolfsonmicro.com>
Message-ID: <201105142233.53659.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 May 2011, Mark Brown wrote:
> > Will a misc device be a better choice.
> 
> > In that case I can remove the MFD cell from the board_file and add an array
> > of platform_device for the UART & CAN.
> 
> I think that for me so long as it can simultaneously do two unrelated
> functions which need to be arbitrated between there's probably a place
> for it in MFD, certainly at the minute.

I guess drivers/mfd would be a better place than drivers/misc, but it might not
need to be an mfd driver in the sense that it registers mfd cells.

The more important point is to remove the device registration from the board
file. You definitely should not have the cells in the board file, but replacing
them with platform devices in the board file makes it no better.

My whole point has been that you register them from the main pruss driver
based on run-time data instead of compile-time pre-configured stuff in the
board file.

	Arnd
