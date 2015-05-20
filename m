From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 16:03:25 +0200
Subject: [PATCH 3/5] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <CABuKBeKiw8MkG5kWaUBqfDzopwvrX8Kh8XpNfRiC_uJD67OcEg@mail.gmail.com>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-4-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omDJ-7+L_46vwMyewHMkMNj69odhp=JY5i6Xj3-Loe6UNA@mail.gmail.com>
 <20150519103010.GA6325@pengutronix.de>
 <CABuKBeKiw8MkG5kWaUBqfDzopwvrX8Kh8XpNfRiC_uJD67OcEg@mail.gmail.com>
Message-ID: <20150520140325.GN6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 01:06:10PM +0200, Matthias Brugger wrote:
> 2015-05-19 12:30 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> >
> > I'll check for errors next round. However, I cannot bail out in this
> > case since once pm_genpd_init() is called the domain cannot be
> > unregistered anymore.
> 
> We should think of implementing this.
> I had a quick look on it, and from what I understand as long as you
> don't have any subdomains, devices and masters added, it's just
> deleting an element from a linked list.

In my error path I would have subdomains added though, so I would need
that to be handled.

> Maybe we should split this in pm_genpd_prepare and pm_genpd_add, with
> the last one actually adding the generic_pm_domain to gpd_list.
> 
> This way we could also get rid of the two for loops.

Well, with pm_genpd_prepare and pm_genpd_add I would still need two
loops, one for preparing and one for adding.

I'm not sure how useful it really is to be able to unregister power
domains. For now I suggest to continue with the domains that are
successfully registered. I'll look into it should the pm domain
maintainers request it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
