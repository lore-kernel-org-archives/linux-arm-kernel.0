From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 Jul 2012 13:57:27 -0400 (EDT)
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <7233708.5ojzueYxjb@flexo>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
 <20120716142941.666d928c@skate> <7233708.5ojzueYxjb@flexo>
Message-ID: <alpine.LFD.2.02.1207161354500.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jul 2012, Florian Fainelli wrote:

> Hi Thomas,
> 
> On Monday 16 July 2012 14:29:41 Thomas Petazzoni wrote:
> > Hello Florian,
> > 
> > Le Sun, 15 Jul 2012 16:49:07 +0200,
> > Florian Fainelli <florian@openwrt.org> a ?crit :
> > 
> > > diff --git a/arch/arm/mach-mcs814x/Makefile.boot b/arch/arm/mach-
> mcs814x/Makefile.boot
> > > new file mode 100644
> > > index 0000000..414db8b
> > > --- /dev/null
> > > +++ b/arch/arm/mach-mcs814x/Makefile.boot
> > > @@ -0,0 +1,3 @@
> > > +    zreladdr-y := 0x00008000
> > > + params_phys-y := 0x00000008
> > > + initrd_phys-y := 0x00400000
> > 
> > params_phys-y and initrd_phys-y are useless for DT-based platforms, if
> > I'm correct.
> 
> Indeed, only zreladdr is actually required.

If you use CONFIG_AUTO_ZRELADDR then even zreladdr-y isn't needed.


Nicolas
