From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Oct 2014 14:31:23 +0200
Subject: [PATCH v3 4/4] arch: arm: boot: dts: Added correct vendor-prefix
 with device name to compatible property
In-Reply-To: <20141007120812.GJ24725@leverpostej>
References: <1412682308-8784-1-git-send-email-darshanapadmadas@gmail.com>
 <11076749.g7xZQflTCQ@wuerfel> <20141007120812.GJ24725@leverpostej>
Message-ID: <8401228.DSnFf2fgRn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 October 2014 13:08:12 Mark Rutland wrote:
> On Tue, Oct 07, 2014 at 12:49:02PM +0100, Arnd Bergmann wrote:
> > On Tuesday 07 October 2014 17:15:08 Darshana Padmadas wrote:
> > >                 /* ALS and Proximity sensor */
> > >                 isl29028 at 44 {
> > > -                       compatible = "isil,isl29028";
> > > +                       compatible = "isl,isl29028";
> > >                         reg = <0x44>;
> > >                         interrupt-parent = <&gpio>;
> > >                         interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
> > > 
> > 
> > Does this intentionally list only the new string?
> > 
> > If we want compatibility between new dts files and old kernels, this would
> > need to be 
> > 
> >       compatible = "isl,isl29028", compatible = "isil,isl29028";
> 
> Are we aiming for new dts wto work with old kernels? It's nice if they
> do, but I don't think it should be necessary. Old DTBs should definitely
> work with a new kernel, though.
> 
> Personally I'd rather see one string (preferably the canonical one, but
> the deprecated one is ok) than two strings when those strings are for
> the exact same device.
> 

Ok, fair enough. I think we should have the new name in dts files
normally then, in order to avoid spreading the mistake further when
someone copies it.

	Arnd
