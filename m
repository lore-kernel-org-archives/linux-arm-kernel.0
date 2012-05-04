From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 21:03:34 +0000
Subject: Handling of modular boards
In-Reply-To: <20120504205441.D293120645E@gemini.denx.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205042039.25794.arnd@arndb.de>
 <20120504205441.D293120645E@gemini.denx.de>
Message-ID: <201205042103.34285.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Wolfgang Denk wrote:
> There are systems (and I bet it will be a growing number) where U-Boot
> itself uses the DT for configuration.  Also, there are functions that
> are needed both by the boot loader and the kernel - for example to
> dislay a splash screen the boot loader needs to initialize the
> display, so it must be able to detect which type of LCD is attached
> (resolution, color-depth, orientation) - the device tree comes in very
> handy here.  Why should Linux re-do all such things?

Sure, there are a lot of things that the boot loader can use from the
device tree, but I'm not sure if the LCD panel connection fits into
the same category as the devices that Mark was thinking of.

Anyway, display controllers are definitely something that needs to
be handled in some way, which may or may not be the same way we
handle more complex collections of arbitrary devices.

	Arnd
