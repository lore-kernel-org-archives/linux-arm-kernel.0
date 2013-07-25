From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 25 Jul 2013 15:56:45 +0200
Subject: Do we have people interested in device tree janitoring / cleanup?
In-Reply-To: <20130725112558.GD24642@n2100.arm.linux.org.uk>
References: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
 <20130725110634.GB2546@localhost.localdomain>
 <20130725112558.GD24642@n2100.arm.linux.org.uk>
Message-ID: <20130725135645.GA17304@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 12:25:58PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 25, 2013 at 12:06:34PM +0100, Dave Martin wrote:
> > On Wed, Jul 24, 2013 at 08:27:13AM -0700, Olof Johansson wrote:
> > > Every now and then I come across a binding that's just done Wrong(tm),
> > > merged through a submaintainer tree and hasn't seen proper review --
> > > if it had, it wouldn't look the way it does. It's something we're
> > > starting to address now since there's more people stepping up to be
> > > maintainers, but there's a backlog of bad bindings already merged.
> > > 
> > > Often they are produced by translating the platform_data structures
> > > directly over into device-tree properties without consideration to
> > > describing the hardware or usual conventions, using key/value pairs
> > > instead of boolean properties, etc.
> > > 
> > > Getting involved in cleaning up these kind of bindings is a great way
> > > to learn "the ways of device tree" for someone that has interest in
> > > that.
> > > 
> > > Latest find in this area is the Maxim 8925 bindings, that I came
> > > across since they caused a compile warning on some defconfig. I'll
> > > post a patch to address the warning but if someone else feels like
> > > fixing the bindings on top of it that would be appreciated!
> > 
> > DT bindings (even poorly conceived, ad-hoc and/or undocumented ones)
> > are ABI.
> > 
> > A review/merge process which _allows_ junk into an ABI is the real
> > problem we need to solve here, but once it's there we can't just magic
> > it away.
> > 
> > Do we plan on having a proper deprecation path for the junk, so that
> > the old, superseded bindings continue to work for a limited time,
> > preferably with a big fat warning somewhere?
> 
> This is the exact problem, and if you've seen how Linus rants about
> the ARM ecosystem breaking ABI stuff all the time, you will start to
> appreciate why ARM is not highly valued in the Linux communities.
> 
> We need to stop this crap getting in.
> 
> We need subsystem people to refuse to merge DT stuff if it hasn't been
> reviewed by DT people - subsystem people are _not_ qualified to accept
> those patches, even if they're responsible for the files which they're
> being applied to. Yes, they can review them, but they should _not_
> accept them without them having the bindings reviewed by folk who (a)
> know the hardware and (b) know the implications of creating a DT binding.
> 
> That means whoever is doing the review of DT bindings probably needs to
> have access to documentation on the hardware - or they need to be educated
> by the submitter.  Or, we need submitters to individually justify why
> each and every property is required in the description.
> 
> As for those already there, I don't think there's anything which can be
> done about them in the short term (short = quite a few years) - we can't
> go removing any properties that are already there, because that will
> break the ABI.  We're basically stuck with that crap for ever now.
> 
> That's the point that people have to understand: if they accept a DT
> description into the kernel, it's basically saying at that point that
> the DT description is the official and definitive description for that
> hardware.  It's just the same as adding a new syscall or something like
> that which the entire world starts to use immediately.  You can't go
> removing or changing it after the fact.
> 
> And this is also why a _hell_ of a lot of thought should go into each
> and every property _before_ it is even proposed by the patch submitter.

So this is the true price for having a nice HW agnostic kernel. I'm seeing
the urgency for an impedence adapter.

Would it be anyhow different with ACPI?

Domenico
