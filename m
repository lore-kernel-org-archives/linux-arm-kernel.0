From: olof@lixom.net (Olof Johansson)
Date: Tue, 19 Nov 2013 10:34:30 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119152157.GO5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <201311191505.33636.arnd@arndb.de>
 <20131119152157.GO5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119183430.GC20967@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 03:21:57PM +0000, Mark Rutland wrote:
> On Tue, Nov 19, 2013 at 02:05:33PM +0000, Arnd Bergmann wrote:
> > On Tuesday 19 November 2013, Mark Rutland wrote:
> > > On Fri, Nov 15, 2013 at 05:52:41PM +0000, Olof Johansson wrote:
> > > > On Fri, Nov 15, 2013 at 09:57:17AM +0000, Mark Rutland wrote:
> > 
> > > > Oh wait, there's people who have been doing this for years. Microsoft. They
> > > > should be the ones driving this and taking the pain for it. Once the platform
> > > > is enabled for their needs, we'll sort it out at our end. After all, that has
> > > > worked reasonably well for x86 platforms.
> > > 
> > > I'm not sure it's entirely reasonable to assume that Microsoft will
> > > swoop in and develop standards that are useful to us or even applicable
> > > to the vast majority of the systems that are likely to exist. If they
> > > do, then we will (by the expectation that Linux should be able to run
> > > wherever another OS can) have to support whatever standards they may
> > > create.
> > 
> > That company is undergoing a lot of change now, I think anything is
> > possible: They might decide that ARM is a really bad idea (after
> > the Windows-RT fiasco), they could start working together with us
> > on these problems, or they could do everything in their hands to
> > make our lives as hard as they can (as before, see
> > http://www.groklaw.net/articlebasic.php?story=2010011422570951).
> >  
> > > Regardless of whether we place support for it into Linux, we should
> > > certainly be spending time now attempting to understand ACPI, what it
> > > does and does not provide, and how it can be moved towards something
> > > that fulfils our needs and we can support long-term. We should certainly
> > > not be taking a back seat approach.
> > >
> > > Outside of the ARM Linux community there is work ongoing to change ACPI
> > > to better suit the level of variation we seem in the ARM space (see
> > > Darren Hart's presentation from ELCE [1]). We need to be involved now in
> > > order to make sure that this is actually generally applicable.
> > 
> > Agreed. I'm not sure who "we" is in this, but I assume you mean the wider
> > ARM Linux developer community.  Linaro already has full-time developers
> > working on this, with ties into the UEFI and ACPI standard bodies, and that
> > is good. Still it does not mean we should prematurely merge any of the
> > code coming out of it, until there are products out there with ACPI firmware
> > that is not completely messed up and that is worth supporting in mainline,
> > considering the maintainance effort.
> 
> Yes, I meant the greater ARM Linux community. I'm aware that Linaro have
> people working full-time on this, but we still need members of the
> greater community to become familiar with ACPI and have an input on it
> before the greater community can realistically expect to support it.

Getting people to join straight from "the community" isn't likely. Or
if people join, it might not be the people you actually need. It's
more likely that people involved both with upstream and other things
at various vendors will join and try to keep things sane.

However, given that UEFI/ACPI is a standards body, the number of actual
software engineers interested in participating in such activity might
be small.

> > I mostly agree, but I think that the decision whether to ignore, translate
> > or implement support for ACPI BIOS implementations depends a lot on
> > what kinds of systems we are going to see and the level of sophistication
> > they put into their firmware.
> > 
> > If we are basically talking about PCs with their x86 CPU removed and
> > an ARM chip put in there, I think an ACPI implementation would be
> > harmless enough. However if we are talking about complex SoCs that just
> > have the same information in ACPI that we have in DT in a different
> > format, we really need to tell the responsible developers that ACPI
> > support for these just won't get merged.
> 
> I mostly agree. However, I'm not so sure on the latter case. If ACPI
> matures support for richer description (as some x86 people are pushing
> for) and it's used in a sane manner, then I don't think we should
> prevent that, especially if the maintenance burden is shared by the
> larger Linux community.

Imposing a maintenance burden on a larger set of users is the completely
wrong way to do this.

I'm hoping what you're meaning to say is that we can share infrastructure
and solutions between the various architectures, which is a completely
different thing than imposing our maintenance on them. :)

Still, I'm with Arnd here: It's not a given at this time that we'll ever
enable ACPI across the board. For the short-to-medium term it certainly
seems like a bad idea to bring in much code for it, and for the longer
term we don't know yet. For a vendor, it's safer to plan for both --
and if you don't care about RT compatibility focus on DT today (but keep
an eye on ACPI developments).


-Olof
