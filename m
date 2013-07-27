From: broonie@kernel.org (Mark Brown)
Date: Sat, 27 Jul 2013 12:36:02 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130727085259.GA6207@netboy>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy>
 <20130726171524.GB28895@obsidianresearch.com>
 <20130727085259.GA6207@netboy>
Message-ID: <20130727113602.GD9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 10:53:01AM +0200, Richard Cochran wrote:
> On Fri, Jul 26, 2013 at 11:15:24AM -0600, Jason Gunthorpe wrote:

> > Why do you think our experiences are so different?

> Here are a few recent examples:

OK, let's go through these...

> * What happens when one wants to boot vanilla kernel on the beaglebone?

>   http://www.spinics.net/lists/arm-kernel/msg198431.html

This actually sounds pretty good - glancing over the thread it seems you
were trying to boot a shiny new board that people were in the process of
trying to upstream support for and were just a bit too early.  Device
tree doesn't seem to have made a difference either way here.

> * Wanting already merged code to work is too much to ask.

>   http://www.spinics.net/lists/linux-omap/msg79731.html

Paul's reply here seems fairly clear - someone had merged a driver which
had been developed in an out of tree or pre-DT environment without DT
support so they just hadn't added DT support.  Sadly doing that is new
feature development and so not appropriate for the stabalisation phase
of development.

> * When people try in good faith to conduct methodical boot tests,
>   DT is working against them.

>   http://www.spinics.net/lists/linux-omap/msg79960.html

Again I don't see anything particularly related to DT here but instead
do with using a SoC and board that are in the early phases of mainline
integration.

I think what you're seeing here is not to do with DT but rather with the
way most SoC vendors engage with mainline - typically they do their SoC
bringup out of tree and then if things do get submitted to mainline that
happens after the SoC is released.  In this respect things seem to have
been going relatively well here, there were clearly active efforts to
get things integrated and facilitate mainline use.

It'd be much better if SoC vendors were to change the way they engage
with the kernel so that support was already in mainline at about the
time the SoC was released but that's a bigger commercial discussion
which isn't really relevant to this one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130727/e72bb460/attachment.sig>
