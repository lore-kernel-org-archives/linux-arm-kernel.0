From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Nov 2013 16:29:44 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131115095717.GC1709@e106331-lin.cambridge.arm.com> <20131115175241.
 GB27174@quad.lixom.net> <20131119113015.GH5914@e106331-lin.cambridge.arm.
 com>
Message-ID: <20131121162944.F087FC406A3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013 11:30:15 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Nov 15, 2013 at 05:52:41PM +0000, Olof Johansson wrote: > > On Fri, Nov 15, 2013 at 09:57:17AM +0000, Mark Rutland wrote:
> > > On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
> The UEFI spec pulls in portions of ACPI. I do not know the full extent
> of the interaction between the two, but I know that they are not
> completely decoupled. As you have pointed out we are not experienced
> with ACPI or UEFI, so I don't think we can make statements that one is
> perfectly fine without the other.

Not actually. The UEFI spec does define how to pass ACPI, but it can
boot the system without any ACPI at all. Merging UEFI support should
pretty much be a non-issue.

> > > I think that trying to shoe-horn ACPI-derived information into device
> > > tree is fundamentally the wrong approach. I don't think it encourages
> > > best practices, and I don't think it's beneficial to the long term
> > > health of Linux or the ecosystem as a whole.
> >
> > There are no known best practices with ACPI. It's a complete fumbling
> > around in the dark right now. We're complaining about reviewer bandwith
> > on DT -- do we have a single reviewer for ACPI on ARM that actually
> > knows what a good solution looks like? I don't think so.
> 
> There are many people in the Linux community who have ACPI experience.
> They may not be active on the ARM side, but it's not fair to say there
> are no known best practices. I will agree that for the level of
> variation we're likely to expect we are pushing the boundaries.

We are pushing a lot of boundaries and doing things on ACPI that have
never been done before. SPI, GPIOs, Clocks, Regulators, composite
devices, key-value properties. All brand new territory, and the Linux
world is driving a lot of it.

> > So, until there's strong evidence that ACPI is actually going to be
> > a sane solution, in other words, until someone has shipped a system
> > that uses it (with Windows) and does it successfully without being
> > a hot mess, we shouldn't litter the kernel with it.
> 
> Again, I'm not sure that we should rely on Windows as our saviour from
> insanity. A lot of the issues we are going to encounter are going to be
> in vendor-specific code (i.e. drivers), and I do not believe that is
> solved by having a single entity in charge of the general frameworks
> those are built upon.

Personally, I think the issue of ACPI support should be taken on a
patch-by-patch basis. A lot of the things that need to be done are quite
discrete and fairly well contained. If the patches don't look that way
then push back on them. For the parts that look ready, go ahead and
merge it. Push back on the ones that don't.

> > Vendors can standardise of UEFI if they want, but I would much rather
> > see them bundle DTB images with their firmware today, than rely on early
> > buggy and still-early-on-the-learning-curve ACPI bindings that we then
> > have to live with forever.
> 
> I agree that today a DTB is preferable to an ACPI implementation.
> 
> I think that mapping from ACPI => DT is less sane than building support
> for ACPI, and is not going to help us in the long term.
> 
> I think that we need to be involved in ACPI from today if we have any
> hope of having something sane in future.

+1

g.
