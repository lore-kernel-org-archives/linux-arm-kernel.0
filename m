From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Aug 2014 11:00:17 +0100
Subject: linux-next: build failures after merge of the drm tree
In-Reply-To: <CAK5sBcHceBqYQOQrWw9D0CviVpnXOdAtfgh7pFkT=L53Gfbe6g@mail.gmail.com>
References: <20140805130926.4e8c8fe5@canb.auug.org.au>
 <53E0736E.7030901@samsung.com>
 <CAOesGMjjLHOaBJZwFENaWW41KFsNZ3pUqiYk0jtet=8NFvce3g@mail.gmail.com>
 <CAOesGMg=kFM_9ksgoOXgqLFjzoE38tCuPy7pxbG5F_j5KovkVA@mail.gmail.com>
 <alpine.DEB.2.00.1408100856270.32072@skynet.skynet.ie>
 <CAK5sBcHceBqYQOQrWw9D0CviVpnXOdAtfgh7pFkT=L53Gfbe6g@mail.gmail.com>
Message-ID: <20140811100017.GA30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 09:26:00AM +0530, Sachin Kamat wrote:
> On Sun, Aug 10, 2014 at 1:28 PM, Dave Airlie <airlied@linux.ie> wrote:
> >>
> >
> > Been on holidays, but ack for anything DT related,
> >
> > Look I wishI knew how DT worked, and what tree is canonical for changes to
> > it, I'm not sure its well defined enough or sub maintaniers know enough,
> > so I do just trust the exynos guys with this.
> >
> 
> Inki,
> 
> Can you please get your tree included in linux-next so that these kind of
> issues could be detected much earlier (even before they hit Dave's tree)?

The answer is not always "stuff your tree into linux-next", but it can
be "learn what's required of maintaining a git tree and/or patch sets".

arm-soc people have asked for a long time that DT updates should go via
themselves rather than through subsystem trees because conflicts there
are rather horrid to deal with, and it's very easy for things to end up
getting out of hand.

Moreover, stuffing a tree into linux-next can cause more harm than good
if the tree owner does not respect the kernel development cycle.  For
example, I notice today that we have new breakage which has appeared in
linux-next which seems to be a change which was never even _compile
tested_ before it was became visible to linux-next, because builds
complain about misplaced ";" and "}".

linux-next is not a build-testing tree; it is an integration tree - it's
there to help tree maintainers find /conflicts/ between their development
trees and resolve those conflicts.  It is not a subsitute for proper
compile testing, it is also not a subsitute for talking to your fellow
developers, and it certainly is not a subsitute for knowing where in the
kernel development cycle things are and knowing what the implications of
that mean for linux-next (and if your tree is part of linux-next, what
it will also mean for /your/ tree.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
