From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Mar 2012 10:24:34 -0800
Subject: [PATCH] pinctrl: resurrect verbose pinmux-pins
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE861991@HQMAIL01.nvidia.com>
References: <1330705873-10798-1-git-send-email-linus.walleij@stericsson.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861978@HQMAIL01.nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861991@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE8619C2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Friday, March 02, 2012 10:41 AM:
> Stephen Warren wrote at Friday, March 02, 2012 10:22 AM:
> > Linus Walleij wrote at riday, March 02, 2012 9:31 AM:
> > > From: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > This reintroduces the verbosity in the pinmux-pins file, now this
> > > file will list all pins, their names, owning device (and if it's
> > > a hog) and also in applicable cases the function and group making
> > > use of that pin right now.
> > >
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > It'd be nice if we could defer this fix until after all the API rework,
> > because it'll cause all kinds of conflicts otherwise.
> 
> Oh, I see this patch is in your for-next branch already before I had a chance
> to comment on it. I guess I'll have write a patch to convert the removed struct
> type to char*s and rebase on top of it:-(

I take that back. Can we please drop this patch and I'll provide an
equivalent in my API rework series?

The main reason is that before the API rework (i.e. what's currently in
pinctrl's for-next branch where the patch was written), the function/group
are set during pinctrl_get(state), whereas after the API rework they aren't
known or set until pinctrl_select_state(state). This is exactly why I
removed the code that saved the function value in the per-pin data-structure
from pinctrl_get() in the first place.

If we don't drop the patch, once of my patches is going to have to
basically include a revert of it, and then a reimplementation of this
patch in the correct place anyway, so we may as well just not apply it
in the first place.

Thanks.

-- 
nvpublic
