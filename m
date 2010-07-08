From: pieterg@gmx.com (pieterg)
Date: Thu, 8 Jul 2010 22:45:59 +0200
Subject: [PATCH 5/5] colibri-pxa3xx: add touchscreen support
In-Reply-To: <201007082203.40209.marek.vasut@gmail.com>
References: <201007081904.16262.pieterg@gmx.com>
	<201007082203.40209.marek.vasut@gmail.com>
Message-ID: <201007082245.59738.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 July 2010 22:03:40 Marek Vasut wrote:
> Dne ?t 8. ?ervence 2010 19:04:16 pieterg napsal(a):
> > Signed-off-by: pieter <p.grimmerink@inepro.com>
> > ---
> >  arch/arm/mach-pxa/colibri-pxa300.c       |    2 +
> >  arch/arm/mach-pxa/colibri-pxa320.c       |    1 +
> >  arch/arm/mach-pxa/colibri-pxa3xx.c       |   31
> > ++++++++++++++++++++++++++++++
> >  arch/arm/mach-pxa/include/mach/colibri.h |    6 +++++
> >  4 files changed, 40 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-pxa/colibri-pxa300.c
> > b/arch/arm/mach-pxa/colibri-pxa300.c
> > index 27f403d..edd48e2 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa300.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> > @@ -229,6 +229,8 @@ void __init colibri_pxa300_init(void)
> >  				mfp_to_gpio(MFP_PIN_GPIO13));
> >  	colibri_pxa300_init_uart();
> >  	colibri_pxa300_init_i2c();
> > +	if (cpu_is_pxa310())
> > +	    colibri_pxa3xx_init_touchscreen();
>
> Is the indent ok here? did you run the patches through checkpatch.pl ?

You're right, I'm missing a tab there. Should have used checkpatch...
I'll send a v2.

Rds, Pieter
