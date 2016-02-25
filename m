From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 13:09:06 -0800
Subject: [PATCH 1/3] dt-bindings: arm/marvell: ABI unstability warning
 about Marvell 7K/8K
In-Reply-To: <20160225161642.GC10593@leverpostej>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456327007-31008-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160224172545.GC9137@leverpostej>
 <20160224211045.379352d3@free-electrons.com>
 <CAL_JsqLevrujSeYNBvSJA-5T0Ho8y7c0fKid7QvVm8LLvYLotw@mail.gmail.com>
 <20160225090927.13492cfb@free-electrons.com>
 <20160225161642.GC10593@leverpostej>
Message-ID: <20160225210906.GS4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 25, 2016 at 04:16:47PM +0000, Mark Rutland wrote:
> On Thu, Feb 25, 2016 at 09:09:27AM +0100, Thomas Petazzoni wrote:
> > Hello Rob,
> > 
> > On Wed, 24 Feb 2016 16:07:04 -0600, Rob Herring wrote:
> > 
> > > You should fix the incomplete information problem. I pushed back on
> > > this, you got more information and already the binding is closer to
> > > reality.
> > 
> > "You should fix the incomplete information problem". You seem to think
> > that it is a simple thing that can be fixed with a magic wand. But it's
> > not.
> > 
> > Either because the internal processes are complicated, or simply
> > because the Linux kernel support is done without cooperation from the
> > HW vendor (it's not the case of this Marvell platform, but it's the
> > case of many other platforms).
> 
> Yes, this is a problem in some cases, and that should be considered in
> those cases. There are always shades of grey.
> 
> Per the above, that isn't relevant in this case. This is a pretty
> black-and-white stand against the usual rules.

Unless your stance, at least on the sunxi discussion was pretty much
black-and-white too. You basically said that we were supposed to
maintain a stable ABI starting right now, even though we know for a
fact that we have bindings that are simply not working.

> > > Mark didn't say don't submit. First, there is value in submitting even
> > > if not accepted immediately and you have to carry some patches for
> > > some time. It was also suggested that you err on the side of less
> > > information in DT if things are uncertain and you have not done that.
> > 
> > Submitting without merging is useless. The point of submitting is to
> > get the code merged, to reduce the amount of out-of-tree patches we
> > have to carry, and to allow users of the platform to simply run
> > mainline on their platform.
> 
> Submitting prototypes and RFCs is the usual way we get things reviewed
> early, and to allow maintainers and others to get a feel for things
> earlier. Submitting patches _for merging_ when you're not sure about
> things and don't want to agree to support them is what's being pushed
> back on.

Just to make sure we're on the same page, are you saying that we must
not merge code unless we're 100% sure of how it works, in its
entirety?

> > So this proposal really doesn't make any sense. Just like Mark initial
> > statement of not submitting code so early.
> 
> As what I said was evidently ambiguous, I'm on about code being _merged_
> prior to being ready. Code and bindings should certainly be posted for
> review as soon as possible. However, it should be recognised when things
> aren't quite ready for mainline.
> 
> Even if something's unclear about a device, you can highlight more
> general issues (e.g. problematic edge cases in common subsystem code),
> and that's possible to have merged even if the binding isn't ready.
> 
> If you're unsure about something, but still want it merged, then you
> have to commit to maintaining that as far as reasonably possible, even
> if it turns out to not be quite right.

Except that *you* are forcing us to maintain code to deal with a use
case that simply doesn't happen, which is the definition of dead code.

Would you be ok to be forced to maintain dead code?

You've been talking about theorical use-cases, do you have any real
world one where someone actually made a case for this DT as an ABI
non-sense?

I mean, we've had the U-Boot sunxi maintainer saying they didn't care,
and actually arguing against it.

As it turns out, he's also involved in the Fedora port. If it was a
pain point for them, don't you think he would have raised it?

The only ones that seem to have a problem with it are the one not
involved in it in any way.

> 
> > > > So please get to an agreement between DT binding maintainers. And stop
> > > > saying this ridiculous statement that HW vendors should stop submitting
> > > > their code to the mainline.
> > > 
> > > You want us to agree, then you won't like the answer. Bindings must be
> > > stable. I'll allow exceptions to that, but not without push back.
> > > 
> > > In general, if there is disagreement about whether stability is
> > > required, then it is required. See the recent sunxi discussion. That's
> > > more between users and platform maintainers though.
> > 
> > Do you realize that this all DT binding stuff is today the *biggest* to
> > getting HW support in the Linux kernel? It has become more complicated
> > to merge a 4 properties DT binding than to merge multiple thousands of
> > lines of driver code. 
> 
> As times have changed, pain points have moved around.
> 
> To some extent that is unavoidable; more up-front effort is required
> where crutches we previously relied on are not applicable.
> 
> Elsewhere we can certainly do better.
> 
> Throwing your hands up and stating "this is unstable, it might change"
> is a crutch. It prevents any real solution to the pain points you
> encounter, and creates pain points for others. It only provides the
> _illusion_ of support.

https://kernelci.org/soc/mvebu/
https://kernelci.org/soc/sunxi/

I guess we should become magicians.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/749d2be4/attachment-0001.sig>
