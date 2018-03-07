From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 7 Mar 2018 08:49:09 +0100
Subject: [PATCH 1/3] drm/sun4i: tcon: Reduce the scope of the LVDS error
 a bit
In-Reply-To: <CAGb2v66vnba4UPvdGS6ber2N2HRANVLAzDArBTApFJ1Su-Gr7w@mail.gmail.com>
References: <20180221125703.4595-1-maxime.ripard@bootlin.com>
 <CAGb2v66vnba4UPvdGS6ber2N2HRANVLAzDArBTApFJ1Su-Gr7w@mail.gmail.com>
Message-ID: <20180307074909.pdt7rohlhjbpe6rh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 06, 2018 at 03:38:25PM +0800, Chen-Yu Tsai wrote:
> > -       /*
> > -        * This can only be made optional since we've had DT nodes
> > -        * without the LVDS reset properties.
> > -        *
> > -        * If the property is missing, just disable LVDS, and print a
> > -        * warning.
> > -        */
> > -       if (tcon->quirks->has_lvds_alt) {
> > -               tcon->lvds_pll = devm_clk_get(dev, "lvds-alt");
> > -               if (IS_ERR(tcon->lvds_pll)) {
> > -                       if (PTR_ERR(tcon->lvds_pll) == -ENOENT) {
> > -                               has_lvds_alt = false;
> > +               /*
> > +                * This can only be made optional since we've had DT
> > +                * nodes without the LVDS reset properties.
> 
> This comment doesn't match the code following it. Otherwise,

It was there before, and it was a typo. I'll send a followup patch

> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

And I've applied all three patches.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180307/1efe6916/attachment.sig>
