From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Apr 2015 21:06:26 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150414162738.GB15807@lukather>
References: <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk>
 <20150404125645.GK14618@lukather>
 <20150404184716.GZ6023@sirena.org.uk>
 <20150407101757.GC15823@lukather>
 <20150408123506.GY6023@sirena.org.uk>
 <20150413081518.GF27783@lukather>
 <20150413114428.GF6023@sirena.org.uk>
 <20150414162738.GB15807@lukather>
Message-ID: <20150414200626.GO6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 06:27:38PM +0200, Maxime Ripard wrote:
> On Mon, Apr 13, 2015 at 12:44:28PM +0100, Mark Brown wrote:

> > There's a difference between actively choosing to do something and
> > having it done by default - the goal here is to make sure that if
> > someone didn't even look at something we're as safe as possible.

> I don't think that discussion is getting anywhere.

> I do understand your point, but I also am under the impression that in
> order to allow people to get the regulators wrong, we place the
> maintainance burden on those who get it right...

Someone is going to be unhappy no matter which default we pick and it
seems better that this is the person who had to type a bit more rather
than the person with hardware damage (or the person who finds their
board suddenly doesn't work because they changed a config option for
that matter).

> > I really don't understand how your explanation follows at all, sorry.
> > How does the ability to use the same PMIC with multiple SoCs influence
> > reference designs?

> Maybe we don't have the same definition for a reference design then,
> but to me, it's a board that is used as a starting point for other
> vendors to create their boards.

Right.

> If so, the central piece of this board is actually the SoC. Having
> multiple SoCs will prevent any sharing of the DTSI, won't it?

If the boards have different SoCs they're probably not the same
reference design, unless they're one of the fully pluggable reference
designs which really don't work well with DT at the best of times.  The
point is that the DTSI for a reference design is for that design not for
the SoC, so for example a DTSI for BeagleBone Black derivatives rather
than a DTSI for the SoC or PMIC on it.

> And like I already said, we're not in such a case anyway. Pretty much
> all boards we've seen so far wire the regulators differently.

OK, so that's the sort of case where this is going to be useful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150414/0292f828/attachment.sig>
