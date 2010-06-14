From: david@gibson.dropbear.id.au (David Gibson)
Date: Mon, 14 Jun 2010 22:44:38 +1000
Subject: Request review of device tree documentation
In-Reply-To: <AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
References: <33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
Message-ID: <20100614124438.GF9323@yookeroo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 11:02:15PM -0600, Grant Likely wrote:
[sni]
> > That's sort of a self-fulfilling prophecy. ?If the OS doesn't trust the
> > firmware, there is no pressure for the firmware to "get it right".
> 
> Firmware will not get it right.  Period.  There will always be
> something wrong.  It is never right on PCs.  It will never be right on
> the other architectures.

Yes, yes, yes.  And there is a great deal of empirical evidence to
back that assertion.

>  That goes for OSes too, but upgrading an OS
> isn't as risky as upgrading firmware.  That isn't to say that it can't
> be close, but every firmware feature that the OS depends on is a
> feature that could force a risky firmware upgrade when the bug in it
> is discovered.

Indeed.  In fact, the general rule of thumb is really "put as much as
possible into the most easily replaced layer of the stack".  This is,
incidentally, why I've always been dubious about simple firmwares
supplying a flattened device tree rather than including the device
tree template in the kernel, cuboot style.

> I'm also convinced that the economics are all wrong for "getting it
> right" when talking about firmware.  Manufactures don't care about
> firmware; they care about selling boxes.  Customers don't care about
> firmware, they care about the operating system (well, that's not true
> either, they care about applications).  For manufactures, once it can
> boot the real operating system, there is little to no incentive to
> spend any more money on firmware when the money can be better spent on
> either the next product or the adding features to the operating system
> of the existing product.  In fact, spending money on firmware is
> actually *more risky* one a product ships, because if a firmware
> upgrade goes bad, then that means product returned for repair at the
> factory.

A good analysis.  The other side of this, is that for an OS, if you
rely on the firmware to do X, it will work when the firmware gets it
right.  If you do X yourself, it will work whether or not the firmware
gets it right.  This means that if there's even one firmware you have
to deal with out there that gets X wrong, you have to do it yourself
and then there is little to no incentive to rely on firmware even in
the cases where it does get it right.  In fact there's a disincentive,
because then you have two different code paths to test and maintain.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
