From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 14 Aug 2014 01:41:46 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <20140812182347.GA4100@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMjs1dM37ZoFA-xs7tYYaXP-XC3NjJsj291bCNoDwAXwiw@mail.gmail.com>
 <20140812182347.GA4100@arm.com>
Message-ID: <2152407.NpXOMHAEH6@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 12, 2014 07:23:47 PM Catalin Marinas wrote:
> On Mon, Jul 28, 2014 at 07:27:52PM +0100, Olof Johansson wrote:
> > On Mon, Jul 28, 2014 at 10:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Mon, Jul 28, 2014 at 05:27:50PM +0100, Olof Johansson wrote:
> > >> On Mon, Jul 28, 2014 at 11:07:50AM +0200, Arnd Bergmann wrote:
> > >> > On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
> > >> > > On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > >> > > > +Relationship with Device Tree
> > >> > > > +-----------------------------
> > >> > > > +
> > >> > > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
> > >> > > > +exclusive with DT support at compile time.
> > >> > > > +
> > >> > > > +At boot time the kernel will only use one description method depending on
> > >> > > > +parameters passed from the bootloader.
> > >> > >
> > >> > > Possibly overriden by kernel bootargs. And as debated for quite a
> > >> > > while earlier this year, acpi should still default to off -- if a DT
> > >> > > and ACPI are both passed in, DT should at this time be given priority.
> > >> >
> > >> > I think this would be harder to do with the way that ACPI is passed in
> > >> > to the kernel. IIRC, you always have a minimal DT information based on
> > >> > the ARM64 boot protocol, but in the case of ACPI, this contains pointers
> > >> > to the ACPI tables, which are then used for populating the Linux platform
> > >> > devices (unless acpi=disabled is set), while the other contents of the
> > >> > DTB may be present but we skip the of_platform_populate state.
> > >>
> > >> How can it be harder to do? If you support acpi=off, then you should support
> > >> acpi=on.
> > >>
> > >> Another alternative would be to have an early fixup that stubs out
> > >> the acpi properties from the DTB unless there's an 'acpi' or 'acpi=on'
> > >> argument on the cmdline. Not quite as tidy a solution, though.
> > >
> > > I don't follow:
> > >
> > > If you want to disable ACPI, you can pass acpi=off. This is your
> > > workaround for broken ACPI (and only if you happen to have wrirten your
> > > own DTB, because many/most ACPI systems WILL NOT have a DTB to begin
> > > with).
> > 
> > All ACPI should be assumed broken at this time, so acpi=off _must_ be
> > the default.
> 
> (catching up with emails after holiday and I may have missed some of
> your arguments)
> 
> If we consider ACPI unusable on ARM but we still want to start merging
> patches, we should rather make the config option depend on BROKEN
> (though if it is that unusable that no real platform can use it, I would
> rather not merge it at all at this stage).

I agree here.

I would recommend creating a separate branch for that living outside of the
mainline kernel and merging it when there are real users.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
