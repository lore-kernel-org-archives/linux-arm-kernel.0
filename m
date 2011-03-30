From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2011 20:24:49 +0200
Subject: [PATCH 0/1] new module for amba axi on-chip interconnect
In-Reply-To: <20110330174010.GA2939@n2100.arm.linux.org.uk>
References: <1301391619-4499-1-git-send-email-arend@broadcom.com>
	<201103301509.04899.arnd@arndb.de>
	<20110330174010.GA2939@n2100.arm.linux.org.uk>
Message-ID: <201103302024.49921.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2011 19:40:10 Russell King - ARM Linux wrote:

> The reason we don't do automatic scanning (which we could on the various
> ARM platforms) is because of the platform data necessary to make some of
> the primecell drivers work.
> 
> Unfortunately, these buses are not as simple as PCI, where a device
> typically sits on its own card and is totally self-contained.  With
> primecell stuff, there's normally some interdependencies between the
> various primecells.
> 
> That doesn't stop there being an automatic enumeration layer, but such
> a layer would need some way of attaching platform specific data to
> specific amba devices.

Right, I understand that this would not completely remove the need for
platform devices, but I think it would be a great step in the right
direction if we could scan all simple devices automatically, or
possibly even all devices in some simple machines.

If we can scan the main resources (memory ranges, interrupts, ...),
that will make it possible to avoid a whole lot of the stuff we currently
do for each new board. It also means we can gradually move away from
statically defined devices, something that Greg has been pushing for
quite some time.

The device tree work has shown that it's possible to describe very
complex hardware in simple data structures, but it would be much
better if we needed neither a device tree nor a board file for this.
As you say, this isn't possible today with the data on available
to the AMBA bus, but I think it would be better to just fill in 
the blanks (and corrections where they are wrong) than to duplicate
all of it as we now do in the kernel.

Ideally, we would point SoC companies to this (or a future extended
version) as the place to add all the required information when
they want the drivers to work out of the box. My impression is that
there is no fundamental difference to buses like PCI or USB, other
than that there is more data required to encode and that there is
a lack of social pressure to get it right. I remember PCI cards
from the 1990s that could not be probed properly and required
setting a lot of module parameters copied from a web site depending
on what hardware you had bought. The reason we don't have that 
as much today is that the manufacturers realized that it's impossible
to write proper drivers if you cannot detect the hardware.

	Arnd
