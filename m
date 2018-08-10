From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Aug 2018 17:50:37 +0100
Subject: [PATCH v2 4/7] drm/i2c: tda998x: convert to bridge driver
In-Reply-To: <20180810161105.GT20303@art_vandelay>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <E1fkBFV-00048s-O2@rmk-PC.armlinux.org.uk>
 <20180808190930.GQ20303@art_vandelay>
 <20180808221547.GN30658@n2100.armlinux.org.uk>
 <20180810161105.GT20303@art_vandelay>
Message-ID: <20180810165037.GQ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 12:11:05PM -0400, Sean Paul wrote:
> On Wed, Aug 08, 2018 at 11:15:47PM +0100, Russell King - ARM Linux wrote:
> > In any case, bridges are buggy with unbinding/rebinding as I've pointed
> > out several times in the past, but TDA998x used with Armada and TI LCDC
> > as it currently stands are not.  So, to do this as a full conversion to
> > bridge and pushing the encoders into the DRM drivers results in a
> > regression for these two DRM drivers.  I'm not willing to accept such
> > a regression, sorry.
> > 
> > Thanks for the other cleanup suggestions, they can be done with a
> > later patch (these changes have already been been merged.)
> 
> I still think you should get review from a bridge maintainer before it goes to
> drm-next.

They are free to review them any time they wish, all the patches are
on dri-devel.  However "before it goes to drm-next" has been impossible
for a while now because David has already pulled it in.

Almost none of my DRM specific patches on dri-devel this time around
received any feedback what so ever, even after myself and David chasing
them up.  Over the Armada changes, David Airlie eventually said to me
"if it works for you, send it to me I suppose".

David also tried poking the tda998x/component discussion thread as well
from the beginning of July (or so David told me), with seemingly the
same result.

So, in summary, it's been almost impossible to get any feedback on any
of the patches and discussions I've sent - I think extracting blood
from a rock might be easier! ;)

I sent a patch about the "broadcast rgb" property - there are no replies
to that email, and it was only in a completely different thread that I
happened to notice a comment about that patch - it is not a sign of a
healthy community to be providing feedback on patches by sending replies
to other threads!  Yet that seems to be happening on dri-devel!

I guess everyone could've gone to the beach (lucky them) because of the
hot weather for the last couple of months, and now that it's cooled down
in some parts, people are starting to re-engage...

If the bridge maintainers eventually get around to reviewing the changes,
then, as I've said, any necessary changes can be made later, but what you
ask is now impossible - they've been in drm-next since Tuesday evening,
and by implication they've been in linux-next too - including last night's
linux-next which is the final one before the merge window opens assuming
it opens on Sunday.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
