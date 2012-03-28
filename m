From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 27 Mar 2012 20:39:34 -0600 (MDT)
Subject: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
In-Reply-To: <4F721A91.7000102@ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
 <4F721A91.7000102@ti.com>
Message-ID: <alpine.DEB.2.00.1203272039010.22961@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, 27 Mar 2012, Jon Hunter wrote:

> On 3/27/2012 4:58, Rajendra Nayak wrote:
>
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c
> > b/arch/arm/mach-omap2/omap_hwmod.c
> > index 8ac26f2..f2a9afa 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
> >    */
> >   static int _omap4_wait_target_disable(struct omap_hwmod *oh)
> >   {
> > -	if (!cpu_is_omap44xx())
> > +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> >   		return 0;
> 
> What about omap36xx?

Unfortunately, cpu_is_omap34xx() also covers OMAP36xx :-(

- Paul
