From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 Nov 2013 21:54:01 +0100
Subject: [PATCH] clk: add flags to distinguish xtal clocks
In-Reply-To: <20131111194247.GB19212@saruman.home>
References: <1382528150.21526.25.camel@porter.coelho.fi>
 <1383933648-28595-1-git-send-email-balbi@ti.com>
 <20131110113716.GN26440@lukather>
 <20131111194247.GB19212@saruman.home>
Message-ID: <20131111205401.GZ26440@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 01:42:47PM -0600, Felipe Balbi wrote:
> > > +	if (of_property_read_bool(node, "clock-xtal"))
> > > +		flags |= CLK_IS_TYPE_XTAL;
> > > +
> > 
> > Introducing a new compatible instead of a property would make more
> > sense here I think.
> > 
> > Do you have a reason not to do so?
> 
> As you can see, this is original work from Luca but I disagree that
> adding a new compatible makes more sense. This still related to a fixed
> rate clock, we're just giving it one extra metadata which will
> differentiate between crystal and oscilator fixed rate clocks.

I don't know, I think it's more a matter of consistency.

If we turn the problem the other way around. Let's say we have a
crystal that for some reason can't be used with clk-fixed-rate. You'd
add a new driver for it, with a compatible of its own, and you'd put
that XTAL flag in there, without any extra metadata in the DT, right?

And I'm pretty sure having a compatible like "clk-xtal" would make it
pretty obvious that it's still a fixed rate clock.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131111/05cc51db/attachment.sig>
