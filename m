From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jan 2015 09:15:56 -0800
Subject: [PATCH 1/7] ARM: OMAP2+: Remove unused ti81xx platform init code
In-Reply-To: <CAALWOA8dSv_nAeme2eX2AZkkofrn7BnC2gLc_81kf_fqtZL18A@mail.gmail.com>
References: <CAALWOA8dSv_nAeme2eX2AZkkofrn7BnC2gLc_81kf_fqtZL18A@mail.gmail.com>
Message-ID: <20150119171556.GX18552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [150118 12:35]:
> > --- a/arch/arm/mach-omap2/usb-musb.c
> > +++ b/arch/arm/mach-omap2/usb-musb.c
> > @@ -82,16 +82,8 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
> >   musb_plat.mode = board_data->mode;
> >   musb_plat.extvbus = board_data->extvbus;
> >
> > - if (soc_is_am35xx()) {
> 
> Was it intentional that this patch also removed a test for am35xx
> (rather than am335x) ?

Oops that was not intentional. However, with the pending patches to
make am3517 dt only, this won't hurt anything as the only legacy
platform then left are omap3430 to omap3730 which us the default
musb-omap2430.

Regards,

Tony
