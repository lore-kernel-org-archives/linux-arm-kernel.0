From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 16:12:42 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <516bfc7f9366ff3ef9187c36dd160888.squirrel@twosheds.infradead.org>
References: <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <20131024122346.GD11296@ulmo.nvidia.com>
 <1382619655.6040.52.camel@sakura.staff.proxad.net>
 <516bfc7f9366ff3ef9187c36dd160888.squirrel@twosheds.infradead.org>
Message-ID: <20131024141241.GA25061@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 01:10:22PM -0000, David Woodhouse wrote:
> 
> >
> > On Thu, 2013-10-24 at 14:23 +0200, Thierry Reding wrote:
> > my point
> >
> > before DT scenario for my hw crypto driver example:
> 
> Note that you are not describing a normal "DT scenario" here. You are
> describing a case in which we screwed up and allowed non-invariant
> features of the hardware to be left out of the DT schema for the device in
> question - apparently because the Linux driver at the time didn't happen
> to use them yet. That was a fundamental mistake and should not have
> happened that way.
> 
> So yes, after the public flogging has happened, and we're trying to work
> out how best to cope with the screwup, we don't necessarily have any
> perfect choices. The perfect choice was to do it properly in the first
> place.

The original point that I was arguing and which triggered my proposal to
allow bindings to be experimental is that we're currently being hindered
to add new features because we're afraid of screwing up. How are we to
know that a binding is sufficient if we can't put it through some real
world testing.

I think asking for DT bindings to be specified in all completeness from
the beginning is unrealistic. There's simply no process in place to do
that. It's taken us the better part of two years to figure out that we
even have a problem.

We've ended up in a situation where software engineers that write the
drivers are required to define hardware in it's entirety before any code
can be merged. In my experience that's very difficult, if not impossible
to do. At the same time hardware engineers aren't very likely to have
heard of DT at all, so they won't be able to come up with a good binding
either.

We can argue forever that DT should describe hardware, but at some point
software engineers need to get involved and work out whether what's in
the binding is sufficient to write a functional driver. This is further
complicated by the fact that unless the people involved *really* know
what they're doing, and even then they may overlook something, the only
way you can be reasonably sure that a DT binding is accurate and
complete is if you have a fully functional driver that implements it.
And the majority of people don't have much experience with DT at all.

Perhaps the solution to aim for in the long run would be to take what we
have learned over the past few years back to vendors and try to get them
to provide the DT bindings along with new hardware. My understanding is
that that's what people have done on architectures that have implemented
DT in the past.

At the same time, the situation we're in is fairly unique, because from
what I can tell, none of the existing DT architectures are anywhere near
as complex or diverse as ARM. Also, even if we can solve this by getting
vendors involved from the start, that doesn't help us now. Unless we
want the better part of ARM to come to a halt for a year or more we need
to find a temporary solution.

Experimental bindings could be a suitable temporary measure, but perhaps
other, better solutions exist.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/22bef7c6/attachment.sig>
