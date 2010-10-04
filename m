From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 3 Oct 2010 23:45:28 -0600 (MDT)
Subject: [PATCH 01/10] OMAP2+: Kconfig: disallow builds for boards that
	don't use the currently-selected SoC
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE2FA@dbde02.ent.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101001213445.1408.96821.stgit@twilight.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE2FA@dbde02.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1010032343250.13816@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Oct 2010, Varadarajan, Charulatha wrote:

>  
> 
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org 
> > [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Saturday, October 02, 2010 3:05 AM
> > To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > Cc: Tony Lindgren
> > Subject: [PATCH 01/10] OMAP2+: Kconfig: disallow builds for 
> > boards that don't use the currently-selected SoC

...

> > +++ b/arch/arm/mach-omap2/board-generic.c
> > @@ -48,10 +48,22 @@ static void __init omap_generic_init(void)
> >  
> >  static void __init omap_generic_map_io(void)
> >  {
> > -	omap2_set_globals_242x(); /* should be 242x, 243x, or 343x */
> > -	omap242x_map_common_io();
> > +	if (cpu_is_omap242x()) {
> > +		omap2_set_globals_242x();
> > +		omap242x_map_common_io();
> > +	} else if (cpu_is_omap242x()) {
> 
> Is this intended for 242x() or 243x()?
> 
> > +		omap2_set_globals_243x();
> > +		omap243x_map_common_io();

That's for 243x().  Thanks, updated that in the branch that's posted on 
git.pwsan.com.


- Paul
