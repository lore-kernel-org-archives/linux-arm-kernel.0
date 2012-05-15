From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 14:23:30 +0000
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120515131935.GI6820@lunn.ch>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C6C@IL-MB01.marvell.com>
 <20120515131935.GI6820@lunn.ch>
Message-ID: <201205151423.31044.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Andrew Lunn wrote:
> > > I would strongly advise on using "mrvl,mv78230" as the binding name. It isn't
> > > as if you can't have multiple names associated with one binding.
> > > 
> > > Also, given how close they are, do we really need separate machine support
> > > files?
> > The problem with 78230 is that it's only one flavor of the AXP family which 
> > includes 78230, 78260 and 78460 resulting different core count, L2 size, DRAM bandwidth, etc.
> 
> Can you explain the naming scheme and mapping to device numbers?
> Please don't limit it to these new devices, but also include the
> existing supported devices. From that we might be able to figure out
> and appropriate naming scheme.

The names and numbers are already extremely confusing in the code we have.
Maybe we can use the addition of the new code as an excuse to clean up
what we have ;-)

I agree that "armada" is a rather bad choice, because chips under that name
include both the pxa/mmp family and the orion/kirkwood/mv78xx0/dove family
which AFAICT don't have much in common at all besides the CPU cores.

One option would be to move all DT-enabled board files under plat-orion
once they are fully done, and leave just the non-DT board files in the
individual directories until they have all been converted. We can start
with the platform code that's being discussed here and move over the
kirkwood and orion5x board-dt.c files once they don't depend on anything
else in those directories any more.

	Arnd
