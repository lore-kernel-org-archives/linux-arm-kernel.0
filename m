From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 May 2011 11:03:24 +0100
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <1306797960.7481.640.camel@pasglop>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<1306797960.7481.640.camel@pasglop>
Message-ID: <20110531100324.GA7067@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 09:26:00AM +1000, Benjamin Herrenschmidt wrote:

> The approach apple uses is interesting, where they essentially use
> device-specific properties that contain a GPIO binding. For example, a
> reset-gpio property, that points to the GPIO doing the reset, etc...

This is exactly what I'm suggesting; it seems like the immediately
obvious approach to take and it's certainly exactly what happens with
the existing platform data code.

> Or we could keep a gpio "map" and have a parallel property to name the
> entries like I was originally thinking for the clocks.

Honestly this would never even have occurred to me; how would that look
and what would the indirection buy us (perhaps seeing how it looks would
make that obvious)?

> In any case, it's something that can reasonably easily be added on top
> of the existing binding, and it would be much more productive Mark if
> you actually proposed solutions rather than just opposing things :-) 

I'm really sorry you feel this way.  All I'm doing here is looking at
the existing platform data, looking at the device tree that's being
proposed and saying "why can't we have something that's as usable as
the platform data?" - I'd have thought that the suggestion was fairly
obvious there.  Just looking at the code it's completely unclear why
we'd even be doing the approach in the original patch in the first
place, Olaf's post was the first I knew about there being some existing
convention here.

One of the problems with the device tree style stuff to people who
haven't used it and can't actually work on it (in my case I have no
systems which can actually boot with a device tree) is that there's this
whole bunch of rules that are already in place that we don't know about
which people just refer us to - witness Olaf's response further up the
thread, he said he queried a similar issue with a SD driver and was
apparently just told that this is the way the device tree does things.

I would anticipate that especially in the early stages of rollout where
device tree is only available on a very limited selection of platforms
you're going to get a bunch of such feedback from maintainers can and
should review the code but are doing so purely based on looking at the
code they're seeing.  I've actually seen a bit of device tree stuff
before but a lot of people won't have done so - if there's stuff people
are querying you're going to have to explain things, even if they're
well established device tree conventions.

This is going to be one of the biggest challenges with rolling out
device tree, both from the point of view of maintainers learning about
how the device tree stuff should look and from the point of view of
maintainers learning who to trust on device tree.  There's a few people
like you and Grant that I know are really familiar with this stuff but
there's also going to be a whole raft of new people submitting device
tree support and if something looks off maintainers are going to have to
work out if it's due to some peculiar device tree idiom or if it's just
an issue in the patch.
