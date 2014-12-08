From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 8 Dec 2014 18:34:32 +0100
Subject: [PATCH v3] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
In-Reply-To: <CAD=FV=V=PDPiDhDmd+j8ePsF43EvuFP-LxKgMKo7ZRBzSMyOJA@mail.gmail.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1418007589-3688-1-git-send-email-addy.ke@rock-chips.com>
 <20141208085202.GA13486@pengutronix.de>
 <CAD=FV=V=PDPiDhDmd+j8ePsF43EvuFP-LxKgMKo7ZRBzSMyOJA@mail.gmail.com>
Message-ID: <20141208173432.GA5732@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > There are different capitalisation of i2c in the patch and the commit log. I
> > don't know what Wolfram prefers here, but using the same spelling
> > everywhere would be nice.
> 
> Can you please point out?  IIRC you should always capitalize I2C in
> prose (descriptions, comments, documentation, etc).  However when used
> in places which specific capitalization standards it should be
> lowercase.  That means file names, directory names, device tree
> property names, etc should be lower case.

This is what I prefer, too. However, I am not too strict about it.
I mean, both are readable.

> >> +     /* Read rise and fall ns; if not there use the default max from spec */
> >> +     if (of_property_read_u32(pdev->dev.of_node, "i2c-scl-rising-time-ns",
> >> +                              &i2c->rise_ns)) {
> >> +             if (i2c->scl_frequency <= 100000)
> >> +                     i2c->rise_ns = 1000;
> >> +             else
> >> +                     i2c->rise_ns = 300;
> >> +     }
> >> +     if (of_property_read_u32(pdev->dev.of_node, "i2c-scl-falling-time-ns",
> >> +                              &i2c->fall_ns))
> >> +             i2c->fall_ns = 300;
> >> +
> > I don't know if other drivers do the same (I assume they should). If so,
> > moving this logic into the core would be nice. I guess this can still be
> > done later.

Let's leave that for later. If we do it, we should start with bus speed
setting first, probably.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/690c9ca3/attachment.sig>
