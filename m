From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 22:35:50 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023181328.GF5208@netboy>
References: <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023094903.GD11954@ulmo.nvidia.com>
 <20131023171620.GA5208@netboy>
 <alpine.LFD.2.03.1310231355160.1951@syhkavp.arg>
 <20131023181328.GF5208@netboy>
Message-ID: <20131023203549.GE8828@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:13:55PM +0200, Richard Cochran wrote:
> On Wed, Oct 23, 2013 at 01:55:24PM -0400, Nicolas Pitre wrote:
> > On Wed, 23 Oct 2013, Richard Cochran wrote:
> > > I still don't understand why someone (linario?) can't host an
> > > arm-dt-devel tree that allows the freedom to change bindings and
> > > features the best source for supporting the latest ARM SoCs. I don't
> > > buy the argument that only Linus' tree gets enough testing. If another
> > > tree really is the best ARM tree, then it will get plenty of attention
> > > and testing.
> > 
> > So you're basically saying that we should split the development effort 
> > across multiple trees instead of encouraging people to converge on the 
> > same tree?  This is completely contrary to all the efforts we've been 
> > deploying to encourage people to submit their code upstream.
> 
> No, just a single tree, please.

In that case, why not just go one step further and leave out that
intermediary tree in the first place? If only code that's completely
finished and never subject to change goes into the upstream kernel, then
it's very unlikely that we'll ever see any support at all for new SoCs
upstream. What would be the incentive for vendors to upstream code if
there's another canonical tree that users can pull from. How is that
different from any other vendor tree?

> > ii> As an end user, I don't mind waiting for a feature if that means
> > > stability and QA. If I get impatient, still I always have the choice
> > > to take a development version. But I do not want to be forced to take
> > > unfinished work in a released kernel.
> > 
> > If as an end user you want full QA, you should go with a distro kernel.
> 
> No, no, NO! I won't ship a distro kernel because they screw things
> up (at least, in my experience). I will ship a 3.x.y stable kernel,
> though.

If you want full QA and feature set, perhaps you should be using a
vendor kernel.

> > We're talking about the upstream kernel here, and given the current 
> > development and release rate we hardly can guarantee you that it'll be 
> > free of unfinished work (as long as it doesn't regress existing 
> > features).
> 
> I read a quote from a Big Cheese saying how the Linux kernel is a
> stable release cycle. There are bugs, to be sure, but, in my
> experience, each release is pretty stable on x86 (but not on arm).

I've already stated this elsewhere, but I'll gladly repeat it here: the
DT, whether with or without stable bindings, should not influence the
stability of the kernel as a whole. That's why I prefer to refer to
bindings that aren't finalized yet as "experimental" rather than
"unstable". Any driver using any binding should not crash if that
binding doesn't look like what it expects.

I also think it's accepted for things to not be perfect from the start.
Nobody expects support for an SoC to be rock-solid when merged. Often
you can't do very much with the initial SoC support when it is merged,
so whether it's stable or not is largely irrelevant.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/04044d49/attachment.sig>
