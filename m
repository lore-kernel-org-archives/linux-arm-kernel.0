From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Aug 2010 13:09:15 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <4C6C3910.80800@codeaurora.org>
References: <4C61EE55.5030506@codeaurora.org>
	<201008181428.45029.arnd@arndb.de> <4C6C3910.80800@codeaurora.org>
Message-ID: <201008191309.15425.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 August 2010, Stephen Boyd wrote:
> So the only sticking point now is that x86, parisc, and arm use warnings 
> and errors but s390 only uses warnings. I guess I'll reword it to be:
> 
>         Enabling this option turns a certain set of sanity checks for
>         user copy operations into compile time warnings/errors.
> 
>         The copy_from_user() etc checks are there to help test if there
>         are sufficient security checks on the length argument of the
>         copy operation, by having gcc prove that the argument is
>         within bounds.
> 
>         If unsure, or if you run an older (pre 4.4) gcc where this
>         option is a no-op, say N.
> 
> or I'll add a patch to make s390 trigger an error when this is enabled?

(Taking Martin and Heiko on Cc for s390)

I'd strongly suggest making the behavior the same for everyone. It should
be fairly easy to make sure none of these warnings ever triggers
on s390, because most of the Linux device driver code does not get build
there anyway.

I'd also drop the part about old compilers and just say
"If unsure, say N".

	Arnd
