From: david-b@pacbell.net (David Brownell)
Date: Thu, 25 Nov 2010 12:22:28 -0800
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <AANLkTinQdNC0XaOqNyDbdYE6ZcP0QyzpN492j=Kovuea@mail.gmail.com>
References: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
	<536589.12568.qm@web180310.mail.gq1.yahoo.com>
	<AANLkTinQdNC0XaOqNyDbdYE6ZcP0QyzpN492j=Kovuea@mail.gmail.com>
Message-ID: <1290716548.2529.136.camel@helium>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-25 at 08:40 +0200, Ohad Ben-Cohen wrote:
> On Thu, Nov 25, 2010 at 5:59 AM, David Brownell <david-b@pacbell.net> wrote:
> > My rule of thumb is that nothing is "generic"
> > until at least three whatever-it-is instances
> > plug in to it.  Sometimes this is called
> > the "Rule of Three".
> >
> > Other than OMAP, what's providing hardware
> > spinlocks that plug into this framework?
> 
> We are not aware of any.

So there's no strong reason to think this is
actually "ggeneric".  Function names no longer
specify OMAP, but without other hardware under
the interface, calling it "generic" reflects
more optimism than reality.  (That was the
implication of my observations...)

To find other hardware spinlocks, you might be
able to look at fault tolerant multiprocessors.
Ages ago I worked with one of those, where any
spinlock failures integrated with CPU/OS fault
detection; HW cwould yank (checkpointed) CPU boards
off the bus so they could be recovered (some
might continue later from checkpoints, etc.)...

> This way platforms [2] can easily plug into the framework anything
> they need to achieve multi-core synchronization. E.g., even in case a
> platform doesn't have dedicated silicon, but still need this
> functionality, it can still plug in an implementation which is based
> on Peterson's shared memory mutual exclusion algorithm 

And maybe also standard Linux spinlocks?

I seem to recall some iterations of the real-time patches doing a lot of
work to generalize spinlocks, since they needed multiple variants.  It
might be worth following in those footsteps.  (Though I'm not sure they
were thinking much about hardware support .

- Dave
