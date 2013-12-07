From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 7 Dec 2013 19:31:30 +0100
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <20131207180215.GQ4360@n2100.arm.linux.org.uk>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312061741.33427.arnd@arndb.de>
 <20131207180215.GQ4360@n2100.arm.linux.org.uk>
Message-ID: <201312071931.30847.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 December 2013, Russell King - ARM Linux wrote:
> On Fri, Dec 06, 2013 at 05:41:33PM +0100, Arnd Bergmann wrote:
> > The above code can already be simplified a lot, since the pre-v6 and
> > pre-v6k v6 cases are dead code. There are comments in Kconfig like this:
> > 
> > config TLS_REG_EMUL
> >         bool
> >         select NEED_KUSER_HELPERS
> >         help
> >           An SMP system using a pre-ARMv6 processor (there are apparently
> >           a few prototypes like that in existence) and therefore access to
> >           that required register must be emulated.
> 
> Arnd,
> 
> If you look at where this is selected, it's selected for SMP on pre-ARMv6
> (okay, I doubt anyone cares about that) _or_ for uclinux on pre-ARMv6
> since pre-ARMv6 can't do the vectors page trick.

Right, I noticed the part about NOMMU later when I read through the code path
again.

> So getting rid of the above takes away __thread support from userland
> uclinux on these CPUs.  Is that something you really want to do?

No, not at all, sorry for the confusion.

	Arnd
