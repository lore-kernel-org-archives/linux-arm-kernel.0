From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jul 2018 16:14:37 +0100
Subject: [PATCH] [SUBMITTED 20180724] arm64: fix ACPI dependencies
In-Reply-To: <CAJZ5v0h1zGHrMo6HLtSMWE4kM9YK-3QvgHnBaRrEpMHAJrrMtg@mail.gmail.com>
References: <20180724094957.1967541-1-arnd@arndb.de>
 <CAJZ5v0jMtWDZePW=mu_cO2PjHVGp1hQThSveq9+=2aNozESENQ@mail.gmail.com>
 <20180724102102.GI19324@arm.com>
 <CAJZ5v0h1zGHrMo6HLtSMWE4kM9YK-3QvgHnBaRrEpMHAJrrMtg@mail.gmail.com>
Message-ID: <20180724151435.GB25412@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 12:23:48PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 24, 2018 at 12:21 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jul 24, 2018 at 11:54:25AM +0200, Rafael J. Wysocki wrote:
> >> On Tue, Jul 24, 2018 at 11:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > Kconfig reports a warning on x86 builds after the ARM64 dependency
> >> > was added.
> >> >
> >> > drivers/acpi/Kconfig:6:error: recursive dependency detected!
> >> > drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
> >> >
> >> > This rephrases the dependency to keep the ARM64 details out of the
> >> > shared Kconfig file, so Kconfig no longer gets confused by it.
> >> >
> >> > For consistency, all three architectures that support ACPI now
> >> > select ARCH_SUPPORTS_ACPI in exactly the configuration in which
> >> > they allow it. We still need the 'default x86', as each one
> >> > wants a different default: default-y on x86, default-n on arm64,
> >> > and always-y on ia64.
> >> >
> >> > Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> > ---
> >> > v2: use 'select ARCH_SUPPORTS_ACPI' for all three.
> >>
> >> LGTM
> >>
> >> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Same here:
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > Would it be ok if I take this via the arm64 tree, since that's where the
> > warning was introduced?
> 
> Yes, it would, from the ACPI side.

Ok, I'll stick this into next tomorrow pending any objections from the x86
maintainers.

Will
