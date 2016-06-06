From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Jun 2016 12:36:00 +0100
Subject: [linux-sunxi] Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <CAOMqctQwFif=yFF1snfZJc7+sGS7wcC-6oNTCfjW_MSUWHw+xQ@mail.gmail.com>
References: <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk>
 <20160601180056.GA4908@lukather>
 <1464842546.23881.3.camel@plaes.org>
 <CAOMqctRMi8Zuwqvakka8LkgvecWVAfzUcER9+ui9WBYS78fWtQ@mail.gmail.com>
 <20160602142649.GJ2282@sirena.org.uk>
 <CAOMqctQwFif=yFF1snfZJc7+sGS7wcC-6oNTCfjW_MSUWHw+xQ@mail.gmail.com>
Message-ID: <20160606113600.GB7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2016 at 01:27:11PM +0200, Michal Suchanek wrote:
> On 2 June 2016 at 16:26, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jun 02, 2016 at 02:14:26PM +0200, Michal Suchanek wrote:

> >> And the code added in that patch will never run unless you

> >> 1) use long spi transfers
> >> 2) compile in/load SPI without DMA support

> >> There is no reason for doing 2) since we have do DMA support for sunxi.

> > Well, presumably such code exists and is being worked on?

> Which code are you referring to?

> This is a reply to patch which adds DMA support to the SPI driver so
> that it can work for arbitrarily long transfers.

It sounded like there might be a missing DMA driver?  Though I think I
was misreading the above.

> > Oh, come on.  You might not want to use it yourself but the chances are
> > that someone will want to use it just like the situation with all the
> > other SPI drivers.  It's a perfectly reasonable and sensible feature to
> > support upstream.

> Is it?

> Once we have *one* driver that works for arbitrarily long transfers
> and it works out of the box with the board defconfig 99% of people who
> will use the SPI driver for anything will use this driver. Any other
> variant will go untested.

We don't want multiple drivers for this and general maintainability
reasons, I'm not sure where the idea that we might want multiple drivers
came from?

> And for the driver to also work without DMA you have to *tell* it to
> probe without DMA because it cannot know you are not going to load a
> DMA driver later.

Yes.  This puts the cost on the special snowflake systems that
absolutely cannot have any DMA support in their systems for some reason
while keeping the driver featureful by default, and keeps that cost
fairly small.

> > I really do not understand why there is such a strong desire to have
> > these devices be a special snowflake here, the worst that's likely to
> > happen here is that you're going to end up having to either remove the
> > DMA controller from the DT or load the driver for it neither of which
> > seem like the end of the world.

> Why would you do that?

Like I say I really don't understand why this is.  I'm just saying there
are ways to do this fairly simply if people really want it on their
systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160606/c5b03fc2/attachment.sig>
