From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Nov 2013 21:31:08 +0100
Subject: ACPI
In-Reply-To: <528ED801.8040705@jonmasters.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <201311220129.54828.arnd@arndb.de> <528ED801.8040705@jonmasters.org>
Message-ID: <201311222131.08787.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 November 2013, Jon Masters wrote:

> By 64-bit ARM server, I mean a system conformant with a series of
> specifications that define what such a server system consists of. It
> might be a physical system featuring an ARM-based SoC containing a core
> conformant to the v8 Architecture, along with standardized peripherals,
> or it might be a virtual platform. The boot architecture would include
> UEFI (specifically a sequential progression from an initial EL3 reset
> secure ROM on through to a verified Tiano build), and ACPI being used to
> convey the platform devices, as well as for runtime event delivery.

Ok, that narrows it down a little, although not in the way I expected.

It seems there is a secret spec along the lines of the older PREP, CHRP,
PAPR. Since the group behind this spec has not yet revealed itself, I will
refer to them as SPECTRE (maybe that should be SPCTR?) for the sake of
discussion.

>From your description, it sounds like SPECTRE is actually trying to make
the job easier for the operating system to some degree by defining a
standard hardware platform. If this actually works out and they hardware
people don't screw up too much, supporting that platform should be
a no-brainer, and I see no fundamental problem with adding ACPI support
for that.

What I also take away from this is that we should not any ACPI support
for platforms that are not SPECTRE compliant, because that would
add a long-term maintainance cost without the benefits, especially
if it ends up implementing an incompatible ACPI dialect. I certainly
don't want to have to maintain two or more versions of ACPI (e.g.
one doing power management using AML and one using SoC specific 
device drivers).

Unfortunately it is impossible to know at this point what work is
actually relevant for SPECTRE and what is not, so we can't really
merge anything specific to ARM64+ACPI until we have access to an
actual spec, or we get a video message by someone with a monocle
and a lap cat to shed some more light on the actual requirements.
There is also the danger that either the SPECTRE spec or the
actual implementations are so screwed up that we still wouldn't
merge anything, but you can probably judge better how likely that
worst-case scenario is.

Those people that have inside knowledge of SPECTRE can in the meantime
work on the patches and get them reviewed (I think this is happening
anyway), and we can certainly keep working with Intel to enable 
whatever features they need for embedded x86 with ACPI.

> I expect to see a series of useful announcements soon that will serve to
> articulate what I am referring to by an ARM v8 server. I will followup
> then with more thoughts about how this fits together.

Sounds good.

	Arnd
