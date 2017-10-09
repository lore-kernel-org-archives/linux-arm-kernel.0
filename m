From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Oct 2017 10:45:28 +0200
Subject: [PATCH 2/3] pinctrl: sunxi: Disable strict mode for old pinctrl
 drivers
In-Reply-To: <CAGb2v656TCA3yqGP=Jb36weFUvQryC=AMi5TxP_tMbz8w-ajdg@mail.gmail.com>
References: <cover.7a61d0bb31530def29efd8b4286d8c0afdaab347.1507236823.git-series.maxime.ripard@free-electrons.com>
 <b09cdfbf4c7546f299031c2923b9f8fcef881e3d.1507236823.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v656TCA3yqGP=Jb36weFUvQryC=AMi5TxP_tMbz8w-ajdg@mail.gmail.com>
Message-ID: <20171009084528.mooy74urkifioqhi@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 06, 2017 at 08:34:07AM +0000, Chen-Yu Tsai wrote:
> On Fri, Oct 6, 2017 at 4:54 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Old pinctrl drivers will need to disable strict mode for various reasons,
> > among which:
> >   - Some DT will still have a pinctrl group for each GPIO used, which will
> >     be rejected by pin_request. While we could remove those nodes, we still
> >     have to deal with old DTs.
> >   - Some GPIOs on these boards need to have their pin configuration changed
> >     (for bias or current), and there's no clear migration path
> >
> > Let's disable the strict mode on those SoCs so that there's no breakage.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 1 +
> >  drivers/pinctrl/sunxi/pinctrl-sun5i.c     | 1 +
> >  drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c | 1 +
> >  drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c | 1 +
> >  drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c | 1 +
> >  drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c  | 3 ++-
> >  drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c | 1 +
> 
> You should also set it for the R_PIO drivers.  IIRC you removed some
> entries for them in your other patchset.

I'll look into the R_PIO that can be switched on, but we won't be able
to enable that flag on the one where we removed nodes.

That would break the old DTs.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171009/35c5530e/attachment.sig>
