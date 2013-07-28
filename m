From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Jul 2013 13:10:21 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130727180752.GB4813@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy>
 <20130726171524.GB28895@obsidianresearch.com>
 <20130727085259.GA6207@netboy>
 <20130727113602.GD9858@sirena.org.uk>
 <20130727180752.GB4813@netboy>
Message-ID: <20130728121021.GN9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 08:07:54PM +0200, Richard Cochran wrote:
> On Sat, Jul 27, 2013 at 12:36:02PM +0100, Mark Brown wrote:

> Yes, lets, and remember the question was, why do I say that dealing
> with DT is such a PITA.

There are definite issues with DT (getting a good process for quality
bindings together being the major one, and we're still working on some
of the subsystem bindings) but we shouldn't conflate other things with
those.  What you and others are saying about the need for a stable ABI
for DT is correct but we're going off on tangents here.

My read on what you're saying is that it's more to do with bleeding edge
stuff being painful than it is to do with DT itself; DT gets mentioned a
lot because it is an active area of development and gets used a lot
during bringup but it's not the cause.

> > >   http://www.spinics.net/lists/arm-kernel/msg198431.html

> > This actually sounds pretty good - glancing over the thread it seems you
> > were trying to boot a shiny new board that people were in the process of
> > trying to upstream support for and were just a bit too early.  Device
> > tree doesn't seem to have made a difference either way here.

> Did you miss the part about CONFIG_ARM_APPENDED_DTB?

It didn't seem terribly relevant - it's a feature if people and/or
systems want to use it.

> > >   http://www.spinics.net/lists/linux-omap/msg79731.html

> > Paul's reply here seems fairly clear - someone had merged a driver which
> > had been developed in an out of tree or pre-DT environment without DT
> > support so they just hadn't added DT support.  Sadly doing that is new
> > feature development and so not appropriate for the stabalisation phase
> > of development.

> This is me asking for maintainers to take patches to fix a driver in
> version v3.7 where the driver merged in v3.4. 

> The patches contain the missing DT part, and the maintainer rejects
> them, saying, no new features!

> Q: What the heck kind of process is that?
> A: DT process.

No, this is nothing to do with DT - this is just the general kernel
development process.  DT was a new feature for that driver (which
would've been merged a year or so before we got our first DT only ARM
platform...), it's unfortunate that you needed it for your system since
it was a DT only system but it's still a new feature with respect to the
driver.

> Seriously, why is it too hard for y'all to insist on merging drivers
> only when they are really, truly ready (and don't forget the DT part,
> please).

There's a couple of things there.  One is that subsystem maintainers
have no real way of telling if a driver actually works unless they
happen to have a system they can test it on.  For the most part that's
just not the case so we have to trust that someone will say something if
there's a problem.  We can spot some problems through review but there's
a huge set that just won't be obvious without knowledge of the hardware.

The other is that a partially featured driver in the kernel tends to be
a better thing for development than something out of tree - if it's
useful for someone that's great and it provides a starting point for
someone else to come along and add more features.  So long as it's not
causing problems at a subsystem level it's generally better to have it
than not, that way other people can come along and incrementally improve
the driver without having to work out some way of collaborating out of
tree.

You mention DT specifically here - obviously a lot of platforms don't
require DT (only some architectures use it at all) so it can't be a
requirement for drivers and if someone's done the work to get the
hardware working it seems more useful to get that merged and then let
someone who cares about DT add the bindings later.

> > > * When people try in good faith to conduct methodical boot tests,
> > >   DT is working against them.

> > >   http://www.spinics.net/lists/linux-omap/msg79960.html

> > Again I don't see anything particularly related to DT here but instead
> > do with using a SoC and board that are in the early phases of mainline
> > integration.

> It is ring around the rosie, DT, boot loader, and kernel.

> Understandably, Paul doesn't want to upgrade his boot loader. He says
> he is "not interested" in testing the boot loader, just the kernel.
> And, if you follow the sage of Paul's test reports, you will find him
> being told to update his boot loader and not to forget the delete old
> dtb files.

> So, like I said, it is a pity PITA.

New systems especially those using new SoCs generally are a pain; had
the issues not mentioned DT they might well have been something else
like missing pinmux in the bootloader, some bit of kernel functionality
not being merged yet or something else.  The flow of discussion there
looks very familiar to me from way before DT was talked about for ARM -
it reminds me a bit of some work I did before even PowerPC adopted DT!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130728/59f819a2/attachment-0001.sig>
