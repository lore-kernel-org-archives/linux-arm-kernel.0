From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 14 May 2011 18:01:27 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <EAA964D5CCD94B4A9544B294E0CF5099@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105102344.58598.arnd@arndb.de>
	<82D549BB195345A1A189D569952B387C@subhasishg>
	<201105112203.54838.arnd@arndb.de>
	<EAA964D5CCD94B4A9544B294E0CF5099@subhasishg>
Message-ID: <20110514160126.GA2791@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 04:25:56PM +0530, Subhasish Ghosh wrote:

> >Instead, maybe you can simply call platform_device_register
> >at that stage to create the children and not use MFD at all.

> >Samuel, can you comment on this as well? Do you still see pruss
> >as an MFD driver when the uses are completely dynamic and determined
> >by the firmware loaded into it?

> But in that case, where do I fit my driver.
> It's a microcontroller inside of a processor, guess that's unique for Linux.

It's not that unusual in hardware terms, really.  There's an awful lot
of this going on in the audio area especially at the minute so there's
going to be some effort around providing some framework support for this
which should have some general usability but that's not there yet.

> Will a misc device be a better choice.

> In that case I can remove the MFD cell from the board_file and add an array
> of platform_device for the UART & CAN.

I think that for me so long as it can simultaneously do two unrelated
functions which need to be arbitrated between there's probably a place
for it in MFD, certainly at the minute.
