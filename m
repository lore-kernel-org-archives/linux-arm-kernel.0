From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Jul 2014 00:48:00 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
Message-ID: <20140701234800.GA23577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 04:42:01PM -0700, Olof Johansson wrote:
> On Tue, Jul 1, 2014 at 4:06 PM, Colin Cross <ccross@google.com> wrote:

> > Would you consider taking support for SWP emulation, enabling CP15
> > barriers (CP15BEN bit only until there's a real device that needs
> > emulation, also requires clearing COMPAT_PSR_E_BIT in
> > compat_setup_return) and enabling SETEND, all behind a default-off
> > CONFIG_DEPRECATED_ARMV7_COMPAT?

> It sounds really silly to push back against this, since it's actually
> needed by so many platforms out there.

> One thing that powerpc did was to add a warning when emulated
> instructions are used (with ratelimiting to avoid DoS). See
> arch/powerpc/kernel/traps.c, ppc_warn_emulated etc. It gives the best
> of both worlds: Lets current software run, but also gives a warning
> that someone should probably try to get it recompiled for best
> performance at some point (for someone who cares about the logs, which
> isn't everybody).

Indeed, Alpha used to do a similar thing when it software emulated
unaligned memory access with pretty good results.  It makes it easy
to identify the source of any performance problems that are observed
and even if none are observed the naming and shaming can get things
updated anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/aa5a4311/attachment.sig>
