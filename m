From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 May 2012 13:05:17 +0000
Subject: [PATCH] maintainership update for the Marvell Orion family of SOCs
In-Reply-To: <20120501084829.GF15541@lunn.ch>
References: <alpine.LFD.2.02.1204301330111.21030@xanadu.home>
 <201204302217.35958.arnd@arndb.de> <20120501084829.GF15541@lunn.ch>
Message-ID: <201205021305.18248.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 May 2012, Andrew Lunn wrote:
> > Well, there is no reason to rush this at all, it could live in parallel
> > for a couple of years. But at one point we can decide that if nobody has
> > bothered to write the .dts file for one board and tested it that nobody
> > cares about that board any more and it can just get removed and possibly
> > added back in dts form when someone does complain.
> 
> Probably a FAQ, but maybe somebody can point me in the right
> direction. How will Debian, Ubuntu, etc, deal with old machines who's
> u-boot does not support DT, yet the kernel has moved on and only has
> DT support for a board? Will the kernel install process need to
> determine what board the machine is and append the DT to the end of
> the kernel?

I think that is the most likely scenario. Another option would be
to provide a replacement or second-stage boot loader that actually
understands DT and that gets loaded instead of the kernel by the
first-stage boot loader.

> Or do we envisage a process where all DT are appended to
> the kernel, and the machine ID, as passed by the old uboot, is used to
> pick the correct DT?

This has been discussed in the past, but IIRC we decided against putting
that logic into the kernel. Folks on devicetree-discuss at l.o.o might remember
the details better than me.

	Arnd
