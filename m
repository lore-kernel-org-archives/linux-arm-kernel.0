From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Dec 2017 10:37:17 +0100
Subject: [PATCH v3 08/15] drm/sun4i: Add LVDS support
In-Reply-To: <CAGb2v67CrZA0WXtQNwrAEvyPuAFa7yJuYdX4GgSoNtBYv2NJ4g@mail.gmail.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <b900e5963180c94ca02bde178b6674622a127787.1512486553.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65Voua-AjHDnCLgDOKqUeSG-yD4wuSO5-BJ230FCp4OuQ@mail.gmail.com>
 <20171207122521.frv5zgaay3sgol6f@flea.lan>
 <CAGb2v67CrZA0WXtQNwrAEvyPuAFa7yJuYdX4GgSoNtBYv2NJ4g@mail.gmail.com>
Message-ID: <20171214093717.nosble24bl5mngub@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 11:30:21AM +0800, Chen-Yu Tsai wrote:
> >> > +       /* Map output pins to channel 0 */
> >> > +       regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
> >> > +                          SUN4I_TCON_GCTL_IOMAP_MASK,
> >> > +                          SUN4I_TCON_GCTL_IOMAP_TCON0);
> >> > +
> >> > +       /* Enable the output on the pins */
> >> > +       regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0xe0000000);
> >>
> >> Is this still needed? You are no longer using the TCON LCD pins
> >> with LVDS.
> >
> > We do. It's a separate function of the pins, but it's the same pins.
> 
> OK. I assume you've tried it without setting it and it failed?
> I just assume that these refer to the TCON LCD output, whereas
> LVDS looks like a separate module and function, and shouldn't
> need it.

Argh, I forgot to test that. I'll test it for real this time and will
update that part with a comment if that's needed.

Sorry :/

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/4cf36874/attachment.sig>
