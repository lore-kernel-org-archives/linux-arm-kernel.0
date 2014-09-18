From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 18 Sep 2014 08:59:32 +0530
Subject: [PATCH v3] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <201409171723.04549.arnd@arndb.de>
References: <1410935510-1567-1-git-send-email-pankaj.dubey@samsung.com>
 <201409171723.04549.arnd@arndb.de>
Message-ID: <000001cfd2f0$c9d0ebd0$5d72c370$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+CC: Dong Aisheng 

Hi Arnd,

On Wednesday, September 17, 2014, Arnd Bergmann wrote,
> > V2 of this patchset and related discussion can be found here [1].
> >
> > Changes since v2:
> >  - Added back platform device support from syscon, with one change that
> >    syscon will not be probed for DT based platform.
> >  - Added back syscon_regmap_lookup_by_pdevname API so that non-DT base
> >    users of syscon will not be broken.
> >  - Removed unwanted change in syscon.h.
> >  - Modified Signed-off-by list, added Suggested-by of Tomasz Figa and
> >    Arnd Bergmann.
> >  - Added Tested-by of Vivek Gautam for testing on Exynos platform.
> 
> Looks fine. Provided you can figure out the problem that Dong Aisheng
reported,
> please add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>

Thanks. 
After he reported I have again done code walk-through of regmap_init_mmio
and 
could not see any such fatal error.  At the same time I have replied to Dong
Aisheng,
asking for more details and waiting for his reply. 
 
> > -}
> > +static struct syscon *of_syscon_register(struct device_node *np);
> >
> 
> One  minor comment: please avoid doing forward declarations of local
functions. It
> took me a while to understand what is going on because I expect all
functions to be
> ordered such that they only get called by functions below, and don't need
this.
> 
> Just move of_syscon_register() here directly.
> 

OK, I will remove forward declaration of "of_syscon_register" and respin
patch once again.

> 	Arnd

Thanks,
Pankaj Dubey
