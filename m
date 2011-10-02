From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 09:03:58 +0200
Subject: ARM SoC tree: OMAP PM dependency on tip irq/core
In-Reply-To: <4E877E29.7000309@gmail.com>
References: <87aa9mm8ts.fsf@ti.com> <87k48pfyvg.fsf@ti.com>
	<4E877E29.7000309@gmail.com>
Message-ID: <1988740.uJMkcEa7Kl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 October 2011 15:55:05 Rob Herring wrote:
> > 
> > Kevin Hilman <khilman@ti.com> writes:
> > 
> >> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
> >> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
> >> in the irq/core branch of Thomas' tip tree[3].
> >>
> >> In the past, I noticed you merged external trees like this to solve
> >> dependencies.
> >>
> >> Could you pull the irq/core branch into your tree to meet this
> >> dependency?
> > 
> > On second thought, since Santosh's branch is the only one with this
> > dependency (and we also have a dependency on Russell's devel-stable)
> > I'll just build up a branch for Santosh's series that includes
> > rmk/devel-stable and tglx/irq-core.
> > 
> 
> Any new platforms will have a dependency on rmk/devel-stable with the
> mach header clean-up. I'll probably have a dependency on tglx's tree as
> well.

Good point. Also, I think in general it's better if I try to keep track
of the depencies myself, so I don't accidentally submit patches upstream
that belong into someone else's realm.

I haven't come up with a good scheme for that yet. Right now I just
add a depends/* branch and try to remember which branches depend on
that. If it gets harder than this, I'll have to write it down somewhere,
but it would be nice to have some tool that can automatically warn
if I try to submit something that has an unfulfilled dependency.

	Arnd
