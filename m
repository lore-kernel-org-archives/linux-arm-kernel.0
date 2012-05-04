From: wookey@wookware.org (Wookey)
Date: Fri, 4 May 2012 15:20:57 +0100
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <CAK2p4sJj7FRVSStVkqmn16sUv8S3vHmUYCU_VzTWAWzqV5yVsg@mail.gmail.com>
References: <201205031350.35476.arnd@arndb.de>
 <CAK2p4sJj7FRVSStVkqmn16sUv8S3vHmUYCU_VzTWAWzqV5yVsg@mail.gmail.com>
Message-ID: <20120504142057.GQ27023@stoneboat.aleph1.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Deepak Saxena [2012-05-03 22:38 -0700]:

> I'm of the opinion that we support DT only platforms for
> multi-platform but this is based on the approach of only caring for
> multi-platform for newer systems and not worrying too much for legacy
> HW.    I don't expect distros (the
> main users of a single zImage IMHO) to spend many cycles on older
> platforms 

Well, it depends exactly what you mean by 'older', and 'spend many
cycles', but distros certainly care about relatively old platforms,
because that's often what users have on their desks, and that is the
driver for what is supported.

Debian tries very hard not to support anything in the kernel that
upstream don't support in the kernel because otherwise it's way too
much work. The current list of supplied arm kernels is:

iop32x (ThecusN2100, intel SS4000, GLAN tank)
ixp4xx (Linksys NSLU2)
kirkwood (*plugs, QNAP NAS, OPenRD)
orion5x (QNAP NAS, HP mv2120)
versatile
mx5
omap

because that's a good compromise between coverage and 'building 20-odd
images'. I have no idea how much of that lot is going to get DTified,
but I'm guessing the older stuff won't be?

We are keen on multiplatform kernels because building a great pile of
different ones is a massive pain (and not just for arm because it
holds up security updates), and if we could still cover all that
lot with one kernel, or indeed any number less than 7 that would be
great. But the focus is very much on 'still in use' hardware, not just
'still newly available' hardware, and definately not 'will be
available sometime' hardware.

So I think that means we'd vote for multiple zImages that did
support non-DT platforms, but my impression of the available effort is
that we'll take what we're given and make the best of it. If the older
stuff has to be supported with current-style one-platform/few machines
kernels then we'll carry on supporting them like that until no-one
cares any more or it's too hard.

Note that that I'm not involved with the Debian arm kernel team, so
this is merely my general impression from afar. Someone closer to the
problem could be more authoratative.

Wookey
