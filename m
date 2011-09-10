From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Sep 2011 22:37:15 +0200
Subject: [PATCH v2] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <20110909205645.GA16355@n2100.arm.linux.org.uk>
References: <3110288.bQbb0H2ME1@wuerfel>
	<20110909193010.GA2993@opensource.wolfsonmicro.com>
	<20110909205645.GA16355@n2100.arm.linux.org.uk>
Message-ID: <201109102237.15193.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011, Russell King - ARM Linux wrote:
> That's just twisted and utterly insane - adding more code for precisely
> zero benefit what so ever.  Think about it - the device tree is already
> creating platform devices for entries in the device tree file.  What's
> the point of having this special ASoC code look up the platform compatible
> property in a table of strings to find a different string to manually
> create a device with.  Why not just add the bloody device to the DT
> file in the first place?  That's partly what DT is there for - to create
> platform specific struct devices.

Exactly. No driver or (worse) user program should ever need to look at
the top-level compatible property. When you want information about a
localized part of the system (e.g. the ASoC components), you should
look up the information for that component.

	Arnd
