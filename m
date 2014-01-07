From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jan 2014 15:41:21 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <20140106162442.GB13111@lunn.ch>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401061637.28194.arnd@arndb.de> <20140106162442.GB13111@lunn.ch>
Message-ID: <201401071541.21449.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 January 2014, Andrew Lunn wrote:

> > That would be rather unfortunate and we should probably
> > try to merge the bindings eventually and make sure that either OS can
> > boot with any conforming DTB
> 
> It probably requires one of the DT maintainers to talk to FreeBSD
> equivalents to get some coordination going. We have a lot of generic
> stuff, like gpio keys, gpio leds, cpu nodes, mtd partitions, etc,
> which could be done at a high level, and then SoC specific nodes
> sorted out between individual developers.

Right. They seem to have quite a selection of dts files by now, which
are roughly comparable to the ones we have, but slightly different
in some aspects.

> > On the example of missing clocks, it should work as long as all relevant
> > clocks are enabled by the boot loader and the clock properties are
> > optional the binding.
> 
> However, not all clocks are optional. We need the clock in order to
> know how fast it ticks. So at least the serial ports and i2c will not
> work, and maybe other devices, i would have to check.

Right. We used to have "clock-frequency" properties defined in a number
of bindings that predate the generic clock binding, but I guess we wouldn't
do that anymore.

	Arnd
