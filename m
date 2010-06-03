From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 03 Jun 2010 16:46:37 -0700
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100603200109.GC9169@n2100.arm.linux.org.uk>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006032155.19349.marek.vasut@gmail.com>
	<20100603200109.GC9169@n2100.arm.linux.org.uk>
Message-ID: <1275608797.23384.328.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-06-03 at 21:01 +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 03, 2010 at 09:55:19PM +0200, Marek Vasut wrote:
> > Dne ?t 3. ?ervna 2010 21:24:59 Russell King - ARM Linux napsal(a):
> > > The subject says everything you need to know.  Randy provided this
> > > link earlier:
> > > 
> > >   http://lkml.org/lkml/2010/6/2/472
> > > 
> > > Linus doesn't appear to be listening to reason, so I see now this as
> > > a fait accompli.  It'll apparantly happen at the next merge window.
> > 
> > The defconfigs age ... there's no point keeping them. They'll be useless crap 
> > unless someone updates them often anyway.
> > 
> > Maybe adding a Kconfig option that's select all the default stuff the platform 
> > needs would be a way to go ? (that was already proposed there)
> 
> The problem comes (as Daniel pointed out _after_ my suggested solution to
> this problem) is if you want to turn off something that's 'selected' in
> this way.
> 
> Anyway, let's not start a new lengthy thread on the subject here; it won't
> have much effect being only on this list.

I think Linus was suggesting that we create Kconfig files that are
strictly used to generate .config files for certain platforms.

So his proposal was to encode everything into Kconfig files, but those
Kconfig options we use don't show up in "make menuconfig" .. so the
whole notion of things not getting unselected doesn't really matter, we
wouldn't end up dealing with it.

You would just generate the .config for whatever sub-architecture you
need, then run "make menuconfig" and select or de-select whatever else
you want.

Daniel
