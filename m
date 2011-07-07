From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 17:57:23 +0200
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support
	=?iso-8859-1?q?for=09imx23/imx28?=
In-Reply-To: <4E1574A1.4050502@freescale.com>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107011109.27206.arnd@arndb.de> <4E1574A1.4050502@freescale.com>
Message-ID: <201107071757.23405.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011, Huang Shijie wrote:
> > On Friday 01 July 2011 10:57:40 Huang Shijie wrote:
> >>>> It's annoying, but it really saves some lines.
> >>> It would save more lines if you introduce the macros globally and
> >>> convert all existing resource definitions ;-)
> >> The origin code did not use any macros.
> >> Some one suggested me to use macros.
> >> So i used the macros.
> >>
> >> Do i have to drop the macros?
> > Can you find out who made the suggestion? Let's first reach consensus
> > about how we want to do these things in the future.
> http://www.spinics.net/lists/arm-kernel/msg121384.html
> 

Ok, so Uwe made a rather generic comment that he'd prefer you to use
macros for that part. I think your original code actually looks cleaner
in this case, mostly because it doesn't obfuscate the identifiers
and because the macro is specific to this file.

Uwe, do you think it's worthwhile introducing a global macro for
everyone to use for defining resources? Clearly this is not an
mxs specific problem, and I'd much rather have the same solution
everywhere.

I'm thinking that if we want to solve this, the macro should live
in include/linux/ioport.h along with struct resource.

	Arnd
