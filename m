From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Dec 2013 18:02:15 +0000
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <201312061741.33427.arnd@arndb.de>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052250.38986.arnd@arndb.de>
 <CAL_JsqLf0Ubi55mc-p0-qPwY0LzHEZ-SF9QwcELkKPfZH=9t_g@mail.gmail.com>
 <201312061741.33427.arnd@arndb.de>
Message-ID: <20131207180215.GQ4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 05:41:33PM +0100, Arnd Bergmann wrote:
> The above code can already be simplified a lot, since the pre-v6 and
> pre-v6k v6 cases are dead code. There are comments in Kconfig like this:
> 
> config TLS_REG_EMUL
>         bool
>         select NEED_KUSER_HELPERS
>         help
>           An SMP system using a pre-ARMv6 processor (there are apparently
>           a few prototypes like that in existence) and therefore access to
>           that required register must be emulated.

Arnd,

If you look at where this is selected, it's selected for SMP on pre-ARMv6
(okay, I doubt anyone cares about that) _or_ for uclinux on pre-ARMv6
since pre-ARMv6 can't do the vectors page trick.

So getting rid of the above takes away __thread support from userland
uclinux on these CPUs.  Is that something you really want to do?
