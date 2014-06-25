From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 25 Jun 2014 12:39:44 +0200
Subject: [PATCH] ARM: imx53: globally disable supervisor protect
In-Reply-To: <CAOMZO5AYeCGHaONawxDbepGCG_2ez810TFxc_5TzC_SNhqOn5g@mail.gmail.com>
References: <1403605229-29623-1-git-send-email-s.trumtrar@pengutronix.de>
 <CAOMZO5AYeCGHaONawxDbepGCG_2ez810TFxc_5TzC_SNhqOn5g@mail.gmail.com>
Message-ID: <20140625103944.GF8053@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Jun 24, 2014 at 08:09:14AM -0300, Fabio Estevam wrote:
> On Tue, Jun 24, 2014 at 7:20 AM, Steffen Trumtrar
> <s.trumtrar@pengutronix.de> wrote:
> 
> > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> > index 2bad387..4d3e750 100644
> > --- a/arch/arm/mach-imx/mach-imx53.c
> > +++ b/arch/arm/mach-imx/mach-imx53.c
> > @@ -29,6 +29,8 @@ static void __init imx53_dt_init(void)
> >         mxc_arch_reset_init_dt();
> >
> >         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +
> > +       imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS2_BASE_ADDR));
> 
> Please retrieve the base address via dt.
> 
> MX53_IO_ADDRESS has gone away in linux-next.
> 

Okay. I will resend with DT parsing.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
