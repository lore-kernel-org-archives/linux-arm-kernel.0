From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 04:28:52 +0100
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131209170617.GC30717@srcf.ucam.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312091735.05014.arnd@arndb.de> <20131209170617.GC30717@srcf.ucam.org>
Message-ID: <201312100428.52588.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, Matthew Garrett wrote:
> 
> On Mon, Dec 09, 2013 at 05:35:04PM +0100, Arnd Bergmann wrote:
> 
> > Exactly. In particular we don't want people to get the wrong idea about
> > where we are heading, so making it possible to use this code on embedded
> > systems for me is a reason not to take the patch.
> 
> People are trying to deploy ACPI-based embedded x86, and most of the 
> ACPI/DT integration discussion seems to have been based on the idea that 
> this is a worthwhile thing to support. If we're not interested in doing 
> so then we should probably make that a whole kernel decision rather than 
> a per architecture one.

Well, except it's not an architecture independent decision. An embedded
x86 SoC will still be very much like a PC, just with a few things added
in and some other bits left out, and you can already describe it mostly
with plain ACPI-5.0. Also, there are only a couple of different non-PC style
devices that Intel is integrating into their SoCs, so we're talking
about a few dozen device drivers here.

The embedded ARM SoCs we have are very much unlike a PC in lots of ways
and there are orders of magnitude more SoCs and on-chip devices that
are potentially impacted by this, so it's definitely not the same thing.

ARM developers are still licking the wounds from a painful migration
from board files to DT, and we will probably spend at least one or
two more years tying up the loose ends from that before we can actually
call that done. We are not ready to go through the same process (or worse)
again any time soon just because x86 does it, and the only reason we're
talking about this for servers is the promise that this is contained to
server-class systems with hardware and firmware people that know what
they are doing and that can make this work as easy as x86 servers
without adding a whole lot of complexity into the kernel.

	Arnd
