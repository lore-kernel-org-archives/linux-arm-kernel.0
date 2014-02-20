From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Feb 2014 14:04:12 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140220121821.GO11878@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1392896076.23342.37.camel@kazak.uk.xensource.com>
 <20140220121821.GO11878@lunn.ch>
Message-ID: <11515265.X2qOAjvHY6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 February 2014 13:18:21 Andrew Lunn wrote:
> 
> What this patchset does is also make mach-mvebu part of the multi v5
> kernel. So you just need one kernel for all ARM v5 machines which are
> part of multi v5. The long term goal is that you need just two 32 ARM
> kernels, multi v5 and multi v7. However orion5x and mv76xx0 are not
> yet part of theses, so we are not there yet.

BTW, if converting enough of orion5x to DT takes too long to
deprecate that platform any time soon, I'd prefer moving it
over to multiplatform while keeping the legacy board files
in there. That should get substantially easier once
mv78xx0, kirkwood and dove have been dealt with and we can
collapse plat-orion and mach-orion5x into one directory.

> > IOW that all of the platforms currently supported by the
> > Debian kirkwood flavour remain supportable in the same binary after this
> > change. It looks like it should be to me, but I'm not 100% sure.
> 
> If you don't support LaCie 2Big and 5Big, HP t5325 thin client and
> Marvell OpenRD then yes, you have one binary. That binary could
> potentially support over v5 machines, but i have no idea what ARM
> machines Debian actually supports. Is there a list somewhere?

http://anonscm.debian.org/viewvc/kernel/releases/linux/3.12.9-1/debian/config/armel/config.kirkwood?view=markup

just lists all kirkwood machines as enabled, but that of course
doesn't meant they are actually working or supported.

	Arnd
