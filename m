From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 11:24:11 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131021170711.GA5256@netboy>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <20131021091555.GB21518@ulmo.nvidia.com>
 <20131021170711.GA5256@netboy>
Message-ID: <20131022092410.GB15640@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 07:07:11PM +0200, Richard Cochran wrote:
> On Mon, Oct 21, 2013 at 11:15:56AM +0200, Thierry Reding wrote:
> > 
> > Right now, we're taking away much of that flexibility and I see progress
> > on ARM actively hindered.
> 
> Baloney.
> 
> No one is taking away your flexibility or hindering progress. It is
> really very simple. Just make an arm-dt-devel tree where you can both
> change the bindings at will and recommend to people.

Oh, I've been doing that for quite a while. In fact the patches that
gave rise to the current frustration have been in a separate tree in
various forms for over a year. But that's not what we want, is it? I
used to think that we actively wanted people to contribute code back
upstream, so telling everyone to keep code in their own trees isn't
helping anyone.

Besides, we all know that people are reluctant to test trees other than
Linus'. That's just the way it is. There is the occasional tester for a
new feature who will be happy to run code from a different tree. I think
those people are an invaluable resource, but I'm pretty sure they'd be
even happier to test the code if they could just take it from Linus'
tree. Nothing ever gets any widespread testing unless it goes into the
mainline kernel.

That's the primary reason why we have things like drivers/staging: we
want people to test code, even things that are considered low quality,
buggy and incomplete. Because that's the way we can make it easy for
people to test code and that allows us to make it better. It is also a
good way to get more people involved. Also, I think that people, given
the choice, often tend to choose functionality over stability.

There's no point at all in running a Linux kernel that never crashes if
it prevents you from using half of the hardware you have. I don't think
we should dictate what drivers people can use based on what we perceive
as qualifying criteria.

Instead what we should be doing is give people a choice. If we tell them
up front that using a given driver (or DT binding) might require them to
update the kernel or DTB at some point because it's likely to change and
if they choose to use it nevertheless, then by all means they should be
allowed to do that.

We're already doing this with staging drivers. I don't see any reason
why we shouldn't be able to do the same with DT bindings. Let's give our
users a warning about tentative or experimental bindings. That way they
can be aware of the potential issues and choose not to use or rely on
them if they want to play it safe. But if they don't mind the occasional
inconvenience, then we shouldn't prevent them from making the best use
of the devices that they have.

> Once bindings have seen some real world testing and have had time to
> mature, then request a merge into mainline.

I don't think that's the way the world works. There simply is no way to
get any real world testing of DT bindings outside of mainline. Sure you
can test-drive code in downstream kernels, but most downstream kernels
have not yet converted to DT and those that have are nothing like the
upstream kernel. Bindings in downstream kernels are likely to be very
broken by upstream standards and therefore any real world testing done
with those will be useless in an upstream context.

We've been preaching for years that vendors should contribute to the
upstream Linux kernel more actively. But I think the only way we can get
them to do that is by making upstream a viable solution. Currently it
isn't for most SoC vendors, because by the time we've finally settled on
a DT binding the hardware for which it was designed has already been
obsoleted. That has resulted in the endless game of catch-up that we've
been playing.

People have been telling vendors that they need to get involved with
Linux upstreaming very early on, at best even prior to having silicon
available. But if it takes months or even years before a driver can be
put to any active use, being blocked by the DT binding being considered
immature, then we loose. There's no point for vendors in contributing to
upstream Linux if they can't eventually take advantage of it. If we ever
want to be able to have something reasonably close to upstream Linux
ship on recent hardware we need to find ways to make it easier to get
code merged faster. Creating additional roadblocks won't help at all.

If that's impossible with DT, then perhaps we really ought to second-
guess whether DT is the right technology. I don't think anyone's been
able to point out a fundamental flaw in DT that would make it useless
for the intended purpose, but various people have pointed out that our
current process may be flawed.

Which brings me back to my earlier point: I think what could really help
alleviate the pain is experimental bindings. If we make it abundantly
clear that someone is using an experimental binding, I don't see why we
shouldn't be able to provide those. This gives us an easy way to test-
drive new bindings and code, but it preserves the possibility to turn
the bindings into stable ones when they are ready, so that they can be
used in production devices.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/e395fe10/attachment.sig>
