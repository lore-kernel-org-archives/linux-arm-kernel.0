From: rpurdie@rpsys.net (Richard Purdie)
Date: Fri, 18 Nov 2011 10:11:33 +0000
Subject: [PATCH 28/41] ARM: restart: pxa: use new restart hook
In-Reply-To: <20111117172734.GZ9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6qW-0001YV-U3@rmk-PC.arm.linux.org.uk>
 <20111117172734.GZ9581@n2100.arm.linux.org.uk>
Message-ID: <1321611093.27449.56.camel@ted>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-11-17 at 17:27 +0000, Russell King - ARM Linux wrote:
> Ack?
> 
> On Sun, Nov 06, 2011 at 05:49:28PM +0000, Russell King - ARM Linux wrote:
> > Hook these platforms restart code into the new restart hook rather
> > than using arch_reset().
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Richard Purdie <richard.purdie@linuxfoundation.org>

> > ---
> >  arch/arm/mach-pxa/balloon3.c            |    1 +
> >  arch/arm/mach-pxa/capc7117.c            |    3 ++-
> >  arch/arm/mach-pxa/cm-x2xx.c             |    1 +
> >  arch/arm/mach-pxa/cm-x300.c             |    1 +
> >  arch/arm/mach-pxa/colibri-pxa270.c      |    2 ++
> >  arch/arm/mach-pxa/colibri-pxa300.c      |    1 +
> >  arch/arm/mach-pxa/colibri-pxa320.c      |    1 +
> >  arch/arm/mach-pxa/corgi.c               |    8 +++++---
> >  arch/arm/mach-pxa/csb726.c              |    1 +
> >  arch/arm/mach-pxa/em-x270.c             |    2 ++
> >  arch/arm/mach-pxa/eseries.c             |    6 ++++++
> >  arch/arm/mach-pxa/ezx.c                 |    6 ++++++
> >  arch/arm/mach-pxa/generic.h             |    2 ++
> >  arch/arm/mach-pxa/gumstix.c             |    1 +
> >  arch/arm/mach-pxa/h5000.c               |    1 +
> >  arch/arm/mach-pxa/himalaya.c            |    1 +
> >  arch/arm/mach-pxa/hx4700.c              |    1 +
> >  arch/arm/mach-pxa/icontrol.c            |    3 ++-
> >  arch/arm/mach-pxa/idp.c                 |    1 +
> >  arch/arm/mach-pxa/include/mach/system.h |   10 +++-------
> >  arch/arm/mach-pxa/littleton.c           |    1 +
> >  arch/arm/mach-pxa/lpd270.c              |    1 +
> >  arch/arm/mach-pxa/lubbock.c             |    1 +
> >  arch/arm/mach-pxa/magician.c            |    1 +
> >  arch/arm/mach-pxa/mainstone.c           |    1 +
> >  arch/arm/mach-pxa/mioa701.c             |    6 +++---
> >  arch/arm/mach-pxa/mp900.c               |    1 +
> >  arch/arm/mach-pxa/palmld.c              |    3 ++-
> >  arch/arm/mach-pxa/palmt5.c              |    3 ++-
> >  arch/arm/mach-pxa/palmtc.c              |    3 ++-
> >  arch/arm/mach-pxa/palmte2.c             |    3 ++-
> >  arch/arm/mach-pxa/palmtreo.c            |    2 ++
> >  arch/arm/mach-pxa/palmtx.c              |    3 ++-
> >  arch/arm/mach-pxa/palmz72.c             |    3 ++-
> >  arch/arm/mach-pxa/pcm027.c              |    1 +
> >  arch/arm/mach-pxa/poodle.c              |    3 ++-
> >  arch/arm/mach-pxa/raumfeld.c            |    3 +++
> >  arch/arm/mach-pxa/reset.c               |    5 ++++-
> >  arch/arm/mach-pxa/saar.c                |    1 +
> >  arch/arm/mach-pxa/saarb.c               |    1 +
> >  arch/arm/mach-pxa/spitz.c               |    6 ++++--
> >  arch/arm/mach-pxa/stargate2.c           |    2 ++
> >  arch/arm/mach-pxa/tavorevb.c            |    1 +
> >  arch/arm/mach-pxa/tavorevb3.c           |    1 +
> >  arch/arm/mach-pxa/tosa.c                |    4 ++--
> >  arch/arm/mach-pxa/trizeps4.c            |    2 ++
> >  arch/arm/mach-pxa/viper.c               |    1 +
> >  arch/arm/mach-pxa/vpac270.c             |    3 ++-
> >  arch/arm/mach-pxa/xcep.c                |    1 +
> >  arch/arm/mach-pxa/z2.c                  |    1 +
> >  arch/arm/mach-pxa/zeus.c                |    1 +
> >  arch/arm/mach-pxa/zylonite.c            |    1 +
> >  52 files changed, 95 insertions(+), 28 deletions(-)
