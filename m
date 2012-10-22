From: horms@verge.net.au (Simon Horman)
Date: Mon, 22 Oct 2012 09:33:51 +0900
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <201210190818.51359.arnd@arndb.de>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
 <20121018081310.GA27117@verge.net.au>
 <20121019030917.GA6644@verge.net.au>
 <201210190818.51359.arnd@arndb.de>
Message-ID: <20121022003350.GL2509@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 08:18:50AM +0000, Arnd Bergmann wrote:
> On Friday 19 October 2012, Simon Horman wrote:
> > On Thu, Oct 18, 2012 at 05:13:10PM +0900, Simon Horman wrote:
> > I have made a limited amount of progress on this trying to create a
> > defconfig that will work on both the Marzen and Armadillo 800 EVA boards.
> > 
> > * Serial console appears to work, although for the Marzen at
> >   least enabling earlyprintk seems to require the bootloader to specify
> >   e.g.  console=ttySC2,115200 earlyprintk
> > 
> >   This is done by fully specifying bootargs in U-Boot.
> >   The boodloaders on the Marzen board has an ampty bootargs by default.
> >
> >   I guess I can live without earlyprink by default,
> >   though it does seem to be a regression in the user experience.
> 
> Right. So who is using the defconfig for these boards? Usually most
> people using it actually have their own configuration files that are
> tuned for their needs, and you often also need to change the command
> line in order to configure the root partition etc.

I imagine they are primarily used by developers, like myself, but
to be honest I am unsure. Ideally I would like the defconfig to be as
useful as possible out of the box. But I agree that most users probably
end up making some customisations, e.g. to the location of the rootfs.

> > * A more significant problem seems to be the use of CONFIG_MEMORY_START
> >   to define PLAT_PHYS_OFFSET in arch/arm/mach-shmobile/include/mach/memory.h
> > 
> >   I'm not sure that I see an easy way to get around this one.
> 
> ARM_PATCH_PHYS_VIRT should take care of this, have you tried it?

Thanks, I will look into that.
