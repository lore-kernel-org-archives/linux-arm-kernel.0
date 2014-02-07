From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Feb 2014 10:03:06 -0500
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140207093313.1a979a8f@skate>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <20140207093313.1a979a8f@skate>
Message-ID: <20140207150306.GX8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 09:33:13AM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri,  7 Feb 2014 00:42:17 +0100, Andrew Lunn wrote:
> > Now that all the device tree support is in mach-mvebu, remove it from
> > mach-kirkwood.
> > 
> > Regenerate kirkwood_defconfig, removing all DT support, and a couple
> > of other redundent options have been removed in the process.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/configs/kirkwood_defconfig |   6 -
> 
> So after this series we have a mvebu_defconfig that only builds the
> ARMv7 platforms of mach-mvebu. I believe this may look strange to
> people looking at the code, seeing that Kirkwood DT support is in
> mach-mvebu, but that mvebu_defconfig doesn't work to build a Kirkwood
> kernel.
> 
> I don't really have a solution, except maybe having mvebu_v7_defconfig
> and mvebu_v5_defconfig to build only the Marvell v7 and Marvell v5
> platforms.

Ideally, I'd prefer multi_v7 and multi_v5 for DT, and
{kirkwood,dove,orion5x,mv78xx0}_defconfig for non-DT legacy building.
The latter going away once we deprecate non-DT booting.  There is a case
to be made for the arch-specific defconfigs, though.

Currently (includes modules if configured, and dtbs);

  mvebu_defconfig	00:02:56
  x86_64_defconfig	00:04:24
  multi_v7_defconfig	00:04:05

1 minute and 9 seconds doesn't drastically change a bathroom break or
tea time ;-)  But it is a 33% increase.

If we want something leaner than multi_v7, how about
armada_370-xp_defconfig to replace the current mvebu_defconfig?

kirkwood_defconfig could enable ARCH_KIRKWOOD and MACH_KIRKWOOD until we
remove legacy boot.  Same with dove_defconfig and the others.

thx,

Jason.
