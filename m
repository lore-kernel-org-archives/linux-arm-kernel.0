From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Nov 2016 09:09:40 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <20161127231009.GA17704@lunn.ch>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
 <1480280279-9552-2-git-send-email-afaerber@suse.de>
 <20161127212709.GD13318@lunn.ch>
 <9500470d-09c3-3ecb-994b-3d108bffc99e@suse.de>
 <20161127220846.GH13318@lunn.ch>
 <e5d45b55-a4c1-3b5e-0bdc-a5e340b072d0@suse.de>
 <20161127231009.GA17704@lunn.ch>
Message-ID: <20161128080939.ippqlytvojitefkp@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Mon, Nov 28, 2016 at 12:10:09AM +0100, Andrew Lunn wrote:
> > Try to see it from my perspective: I see that some vf610 device I don't
> > have (found via `git grep marvell,mv88e6` or so) uses
> > "marvell,mv88e6085". I then assume it has that device on board. How
> > would I know it doesn't? Same for the other boards you mention.
> > 
> > Unfortunately some of your replies are slightly cryptic. Had you simply
> > replied 'please just use "marvell,mv88e6085" instead', it would've been
> > much more clear what you want. (Same for extending the subject instead
> > of just pointing to some FAQ.)
> 
> By reading the FAQ you have learnt more than me saying put the correct
> tree in the subject line. By asking you to explain why you need a
> compatible string, i'm trying to make you think, look at the code and
> understand it. In the future, you might think and understand the code
> before posting a patch, and then we all save time.

I agree to Andreas though, that it makes an school teacher impression.
Something like:

	Please fix the subject. Check the FAQ for the details, which btw
	is worth a read completely.

is IMHO better in this regard and once you found the problem there you
don't need to ask back if it's that what was meant.

> > So are you okay with patch 1/2 documenting the compatible? Then we could
> > drop 2/2 and use "marvell,mv88e6176", "marvell,mv88e6085" instead of
> > just the latter. Or would you rather drop both and keep the actual chip
> > a comment?
> 
> A comment only please.

I still wonder (and didn't get an answer back when I asked about this)
why a comment is preferred here. For other devices I know it's usual and
requested by the maintainers to use:

	compatible = "exact name", "earlyer device to match driver";

. This is more robust, documents the situation more formally and makes
it better greppable. The price to pay is only a few bytes in the dtb
which IMO is ok.

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161128/c9e0e382/attachment.sig>
