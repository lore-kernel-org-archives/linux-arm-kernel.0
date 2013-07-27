From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 27 Jul 2013 20:07:54 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130727113602.GD9858@sirena.org.uk>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy>
 <20130726171524.GB28895@obsidianresearch.com>
 <20130727085259.GA6207@netboy>
 <20130727113602.GD9858@sirena.org.uk>
Message-ID: <20130727180752.GB4813@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 12:36:02PM +0100, Mark Brown wrote:
> On Sat, Jul 27, 2013 at 10:53:01AM +0200, Richard Cochran wrote:
> > On Fri, Jul 26, 2013 at 11:15:24AM -0600, Jason Gunthorpe wrote:
> 
> > > Why do you think our experiences are so different?
> 
> > Here are a few recent examples:
> 
> OK, let's go through these...

Yes, lets, and remember the question was, why do I say that dealing
with DT is such a PITA.
 
> > * What happens when one wants to boot vanilla kernel on the beaglebone?
> 
> >   http://www.spinics.net/lists/arm-kernel/msg198431.html
> 
> This actually sounds pretty good - glancing over the thread it seems you
> were trying to boot a shiny new board that people were in the process of
> trying to upstream support for and were just a bit too early.  Device
> tree doesn't seem to have made a difference either way here.

Did you miss the part about CONFIG_ARM_APPENDED_DTB?

> > * Wanting already merged code to work is too much to ask.
> 
> >   http://www.spinics.net/lists/linux-omap/msg79731.html
> 
> Paul's reply here seems fairly clear - someone had merged a driver which
> had been developed in an out of tree or pre-DT environment without DT
> support so they just hadn't added DT support.  Sadly doing that is new
> feature development and so not appropriate for the stabalisation phase
> of development.

This is me asking for maintainers to take patches to fix a driver in
version v3.7 where the driver merged in v3.4. 

The patches contain the missing DT part, and the maintainer rejects
them, saying, no new features!

Q: What the heck kind of process is that?
A: DT process.

Seriously, why is it too hard for y'all to insist on merging drivers
only when they are really, truly ready (and don't forget the DT part,
please).

> > * When people try in good faith to conduct methodical boot tests,
> >   DT is working against them.
> 
> >   http://www.spinics.net/lists/linux-omap/msg79960.html
> 
> Again I don't see anything particularly related to DT here but instead
> do with using a SoC and board that are in the early phases of mainline
> integration.

It is ring around the rosie, DT, boot loader, and kernel.

Understandably, Paul doesn't want to upgrade his boot loader. He says
he is "not interested" in testing the boot loader, just the kernel.
And, if you follow the sage of Paul's test reports, you will find him
being told to update his boot loader and not to forget the delete old
dtb files.

So, like I said, it is a pity PITA.

Thanks,
Richard
