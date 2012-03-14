From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 17:00:06 +0000
Subject: [PATCH v4 00/11] ep93xx: Move SoC private bits to core
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020695AB9B9B@AUSP01VMBX24.collaborationhost.net>
References: <1331592502-9083-1-git-send-email-rmallon@gmail.com>
 <201203141351.06200.arnd@arndb.de>
 <ADE657CA350FB648AAC2C43247A983F0020695AB9B9B@AUSP01VMBX24.collaborationhost.net>
Message-ID: <201203141700.06226.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, H Hartley Sweeten wrote:
> On Wednesday, March 14, 2012 6:51 AM, Arnd Bergmann wrote:

> > As the first steps (after reading Documentation/devicetree/booting-without-of.txt)
> > the best way forward is probably to take you favourite board file and
> > add a DT_MACHINE_START section so you can boot the same machine
> > when passing an empty devicetree rather than ATAGS. Then add the interrupt
> > controller (should be simple for VIC), followed by gpio (needs bindings,
> > see Documentation/devicetree/bindings/gpio/*.txt), i2c and spi. After
> > you have all that infrastructure in place, you can convert every other
> > device, one at a time. Some (anything without platform_data) will be
> > Trivial, others require you to come up with a new binding document
> > and properties to replace the platform_data. Many people try to do
> > the ones from board files first because it lets them remove the board
> > files, and only after that look at converting the core devices, but you
> > can do any order you like.
> 
> The main problem I see with converting the ep93xx platform to device tree
> is that it requires modifying the bootloader. Correct me if I am wrong.

You can always use legacy bootloaders with an appended device tree.
It's slightly less interesting that way but it still works. You can
also use a second-stage boot loader, but that would require having
one that supports your platform.

	Arnd
