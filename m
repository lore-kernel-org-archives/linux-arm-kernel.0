From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jan 2017 12:05:46 +0100
Subject: [PATCH v5 6/13] mmc: sunxi: Add EMMC (MMC2) controller compatible
In-Reply-To: <CAPDyKFr3cnFux4NRzZ9UAn93MOVb6RaQQ+PHDxGztciDHZSX9A@mail.gmail.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
 <bcbeeb726c5638361590bd4c295279ef92d44209.1485553113.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFr3cnFux4NRzZ9UAn93MOVb6RaQQ+PHDxGztciDHZSX9A@mail.gmail.com>
Message-ID: <20170130110546.6q5xb3p2uvncrrmf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 11:06:05AM +0100, Ulf Hansson wrote:
> On 27 January 2017 at 22:38, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The MMC2 controller on the A64 is kind of a special beast.
> >
> > While the general controller design is the same than the other MMC
> > controllers in the SoC, it also has a bunch of features and changes that
> > prevent it to be driven in the same way.
> >
> > It has for example a different bus width limit, a different maximum
> > frequency, and, for some reason, the maximum buffer size of a DMA
> > descriptor.
> >
> > Add a new compatible specifically for this controller.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Tested-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index 6bbe61397b7c..f0f6922bca8a 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -5,6 +5,7 @@
> >   * (C) Copyright 2013-2014 O2S GmbH <www.o2s.ch>
> >   * (C) Copyright 2013-2014 David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> >   * (C) Copyright 2013-2014 Hans de Goede <hdegoede@redhat.com>
> > + * (C) Copyright 2017 Sootech SA
> >   *
> >   * This program is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU General Public License as
> > @@ -1096,12 +1097,19 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
> >         .needs_new_timings = true,
> >  };
> >
> > +static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
> > +       .idma_des_size_bits = 13,
> > +       .clk_delays = NULL,
> > +       .can_calibrate = true,
> > +};
> > +
> >  static const struct of_device_id sunxi_mmc_of_match[] = {
> >         { .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
> >         { .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
> >         { .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
> >         { .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
> >         { .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
> > +       { .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
> 
> This should be documented in the DTS docs for sunxi as well. I expect
> you to send a patch on top to take care of that.

You're right, I'll send a patch today.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/14494a7f/attachment-0001.sig>
