From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 23:04:05 +0200
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support
	for?imx23/imx28
In-Reply-To: <20110707204833.GL29624@pengutronix.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107071757.23405.arnd@arndb.de>
	<20110707204833.GL29624@pengutronix.de>
Message-ID: <201107072304.05626.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 22:48:33 Uwe Kleine-K?nig wrote:
> My thoughts on this is that it should better go to where struct resource
> is defined (<linux/ioports.h>, as Arndt suggested) but then probably a
> bit more generic as:
> 
>         #define RES_MEM_NAMED(_start, _end, _name)                      \
>                 {                                                       \
>                         .start = _start,                                \
>                         .end = _end,                                    \
>                         .name = _name,                                  \
>                         .flags = IORESOURCE_MEM,                        \
>                 }
>         #define RES_MEM(_start, _end)                                   \
>                 RES_MEM_NAMED(_start, _end, NULL)
> 
> (Maybe alternatively take a _size parameter instead of _end?)
> While this makes the repetition shorter, it's still there.
> 

This sounds reasonable, and I'd also prefer the size instead of end
argument here. If you prepare a patch to do this, I can ack it for you.

	Arnd
