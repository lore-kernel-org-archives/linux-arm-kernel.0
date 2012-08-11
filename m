From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Aug 2012 12:36:37 -0400
Subject: [PATCH 2/3] ARM: Kirkwood: ts219: fix Makefile.boot after dts
 was split in two
In-Reply-To: <20120811075114.GD30947@lunn.ch>
References: <cover.1344651264.git.jason@lakedaemon.net>
 <4b59ab4618c9b9c055831f6b96636741bda5d42f.1344651264.git.jason@lakedaemon.net>
 <20120811075114.GD30947@lunn.ch>
Message-ID: <20120811163637.GD22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 09:51:14AM +0200, Andrew Lunn wrote:
> On Sat, Aug 11, 2012 at 02:39:46AM +0000, Jason Cooper wrote:
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> >  arch/arm/mach-kirkwood/Makefile.boot |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
> > index 2a576ab..2ad83e2 100644
> > --- a/arch/arm/mach-kirkwood/Makefile.boot
> > +++ b/arch/arm/mach-kirkwood/Makefile.boot
> > @@ -7,7 +7,7 @@ dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns320.dtb
> >  dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
> >  dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
> >  dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
> > -dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
> > +dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-ts219-6281.dtb kirkwood-ts219-6282.dtb
> 
> Hi Jason
> 
> There is the same fix from Arnaud Patard, which has been posted to the
> list maybe a week ago.

dabbit!  I even have that flagged to pull in as a 3.6 fix.  I'll drop
mine, and use his.

> We seem quite good at breaking Makefile.boot and not noticing it. Who
> maintains kisskb? We should ask for make dtbs to be added to the end
> of the build scripts.

I have it in my build tests here (that's how it came up), but we'll see
if they are ammenable to adding 'make dtbs'.

thx,

Jason.
