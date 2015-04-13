From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Apr 2015 12:44:28 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150413081518.GF27783@lukather>
References: <551538AB.50207@redhat.com> <55169622.5070007@gmail.com>
 <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk>
 <20150404125645.GK14618@lukather>
 <20150404184716.GZ6023@sirena.org.uk>
 <20150407101757.GC15823@lukather>
 <20150408123506.GY6023@sirena.org.uk>
 <20150413081518.GF27783@lukather>
Message-ID: <20150413114428.GF6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 10:15:18AM +0200, Maxime Ripard wrote:
> On Wed, Apr 08, 2015 at 01:35:06PM +0100, Mark Brown wrote:
> > On Tue, Apr 07, 2015 at 12:17:57PM +0200, Maxime Ripard wrote:
> > > On Sat, Apr 04, 2015 at 07:47:16PM +0100, Mark Brown wrote:

> > > > Or the regulator is used by some passive component on the board that
> > > > doesn't appear in DT (or some driver that doesn't yet have DT support
> > > > doesn't claim the regulator) and it gets switched off.  Or we power it
> > > > off and then later discover that we've been placing physical stress on
> > > > the system.

> > > Isn't that what the regulator-always-on property is here for?

> > Only if it's actually added by someone after having looked at the
> > system...

> True, but that can also be said for pretty much any DT patch. If you
> do something wrong in your DT and haven't looked carefuly at your
> datasheet/schematics, here be dragons.

There's a difference between actively choosing to do something and
having it done by default - the goal here is to make sure that if
someone didn't even look at something we're as safe as possible.

> > > > Providing .dtsis for reference designs can make sense, if there's a
> > > > widely cloned board with lots of common design elements then reusing
> > > > that .dtsi is fine but clearly that .dtsi isn't going to enable the full
> > > > flexibility of the regulators since there will be constraints from that
> > > > reference design.

> > > That PMIC is used with various SoCs, so that's not really an
> > > option. And especially when it comes to regulators, I don't think
> > > there's really a pattern that emerged yet...

> > I'm not sure you saw the "reference design" part of the above?

> I saw that, I was just saying that this doesn't really work for us
> unfortunately.

I really don't understand how your explanation follows at all, sorry.
How does the ability to use the same PMIC with multiple SoCs influence
reference designs?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150413/03c6949b/attachment.sig>
