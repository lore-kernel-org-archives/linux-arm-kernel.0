From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 22:14:38 +0100
Subject: [PATCH v6 0/5] Basic ARM devicetree support
In-Reply-To: <BANLkTi=yCmxgv1fQKRJSZK3FkkRwjS2r=Q@mail.gmail.com>
References: <BANLkTi=yCmxgv1fQKRJSZK3FkkRwjS2r=Q@mail.gmail.com>
Message-ID: <20110511211438.GM5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 10:44:49PM +0200, Grant Likely wrote:
> Right now it merges cleanly with linux-next and the resulting tree
> builds and boots at least on qemu.  Unless you really object, I'm
> going to ask Stephen to add the following branch to the /end/ of the
> list of trees for linux-next so it can easily be dropped it if it
> causes any problems.

As far as the set of five patches looks fine to me, I don't have any
objections against them.  So I think we can merge them for .40.

What I've always worried about is the platform stuff, and that's
something I'm going to continue worrying about because I don't think
we have sufficient review capacity to ensure that we don't end up
with lots of stupidities.

Eg, we need to properly sort out how we're going to represent stuff
so we don't end up with X IRQ controllers, Y clock events, etc.  In
other words, I don't want to see DT growing an AT91 IRQ controller,
PXA IRQ controller, SA1100 IRQ controller, etc.

One of the things we must deal with is how do we reduce the amount
of IRQ controller code, clock event code, etc that we have in the
kernel tree.  That means coming up with some generic representation
of these facilities and having the right DT properties in place to
be able to describe to the generic representation what's required of
it.

If we can't do that, then DT isn't solving the problem which Linus
has complained about, and we will still be in the situation where
platform X wants its own IRQ controller, clock event, etc code.
