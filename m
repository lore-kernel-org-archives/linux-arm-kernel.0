From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 28 Jun 2012 12:44:30 +0000
Subject: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <20120628123207.GG19842@atomide.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A0812@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Jun 28, 2012 at 18:02:07, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120628 02:36]:

> > diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> > index c8a9487..bbae674 100644
> > --- a/arch/arm/mach-omap2/gpmc-onenand.c
> > +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> > @@ -364,6 +364,8 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
> >         struct gpmc_timings t;
> >         int ret;
> > 
> > +       omap2_onenand_set_async_mode(onenand_base);
> > +
> >         t = omap2_onenand_calc_async_timings();
> > 
> >         ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
> 
> Yes that seems to do the trick, thanks! I can fold that into the
> breaking patch when applying.


Also following needs to be removed from commit message,

"Ensuring sync read/write are disabled in onenand cannot
be expected to work properly unless GPMC is setup, this
has been removed."

With the above diff we are in effect disabling sync mode in
onenand before GPMC has been setup in the Kernel

If you want, I can sent a new series too.

Regards
Afzal
