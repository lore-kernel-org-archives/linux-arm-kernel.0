From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 21:20:50 -0700
Subject: [PATCH 04/12] ARM: shmobile: r8a7740: Add DT name to clock list
 for CMT10
In-Reply-To: <201305312339.05762.arnd@arndb.de>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <20130528062246.GB20031@quad.lixom.net>
 <CANqRtoRwBHY1+Tgekg1CocZa4zWCAUWuZnW=5MXTA9SPcWYD0A@mail.gmail.com>
 <201305312339.05762.arnd@arndb.de>
Message-ID: <20130601042050.GC3868@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 11:39:05PM +0200, Arnd Bergmann wrote:
> On Friday 31 May 2013, Magnus Damm wrote:
> > With mach-shmobile we have deliberately chosen to avoid AUXDATA. The
> > reason for that is that we keep the DT version of a device clean from
> > the beginning so it is kept totally free of platform data while in
> > parallel we also have a regular platform device with platform data for
> > the old legacy C version of board support. Other ARM subarchitectures
> > seem to use DT together with platform data which is a step that we
> > prefer to skip by using a C version and a DT version of board support
> > in parallel. The idea is that we should be able to existing level of
> > support in the C version while incrementally doing development on the
> > DT -reference code. Then drop the C version when the DT version has
> > become good enough. Current blockers are GPIO/PFC DT and common clock
> > framework.
> 
> I think this makes sense and you we shouldn't force you as the platform
> maintainer to do it the other way. Incrementally removing the auxdata
> and platform_data structures as most platforms do is nice in the sense
> that it allows you to have a fully working system booting with DT
> from the start and to reduce the amount of code as early as possible,
> and for instance this has worked rather well on kirkwood/orion/dove/mvebu.
> 
> The price for that method is that you end up having to coordinate patches
> carefully between subsystems so you first add DT support to a driver,
> and then atomically change the dts file and the board file to the
> method. With your way, you can avoid a lot of the trouble we've seen
> on other platforms with complex dependency graphs or broken
> bisection.

Well, or at least you have to add the auxdata table entries as you enable
drivers, it doesn't have to be strictly coordinated.

Anyway, that isn't really worth arguing here since it's not relevant to
the shmobile case. If doing clocks this way makes more sense for you
for now, you should continue with it. Sounds like people are aware of
the trade-offs, etc.

> > > Where are you guys at on your plans for getting DT_based clock going? That will
> > > sort of indicate just how temporary these clock alaises will be. I'm guessing
> > > we'll be living with them for a while though?
> > 
> > I have to deal with LPAE soon according to my todo list. After that I
> > will make sure common clock conversion starts moving. There are many
> > SoCs to convert, so it will have to happen gradually. I doubt we will
> > get any code ready for merge in v3.11, getting some bits into v3.12 is
> > probably possible.
> > 
> > Apart from moving to common clocks and after that adding support for a
> > single multi-subarch kernel binary, is there anything you want us to
> > implement? Anything for v3.11? I'd like to get the memory bits sorted
> > out if possible.
> 
> My preference would be if you can get CONFIG_MULTIPLATFORM to work on
> as many of your SoCs as possible, but that depends on having at least
> some support for COMMON_CLK.

Yep, agreed. Thanks for the update on your plans as well, Magnus.


-Olof
