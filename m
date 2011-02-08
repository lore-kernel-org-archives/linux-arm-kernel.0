From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Feb 2011 20:24:00 +0530
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org><201102081311.52004.arnd@arndb.de><20110208121334.GB22877@n2100.arm.linux.org.uk><201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
Message-ID: <19a3630aad67b496a4e36354abc63c4a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin at linaro.org]
> Sent: Tuesday, February 08, 2011 8:16 PM
> To: Arnd Bergmann
> Cc: linux-arm-kernel at lists.infradead.org; Russell King - ARM Linux;
> Nicolas Pitre; Tony Lindgren; Santosh Shilimkar; linux-
> omap at vger.kernel.org; Jean Pihet
> Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
>
[....]

> For (2), I think the best approach is to use the actual "wfi"
> instruction and build the affected files with the appropriate -
> march=
> flag (omap already does that) - since those CPU-specific files
> should
> by definition never be run if running on another CPU.  We only
> support
> new enough tools these days that this should be supported; so "wfi"
> should be preferable to ".long 0xdeadbeef" - otherwise we need lots
> of
> #ifdef CONFIG_THUMB2_KERNEL, or a macro.  If we have a macro, it
> would
> be better for that to be generically implemented somewhere, becasue
> the requirements are the same for every BSP supporting v7.
>
> I don't like the practice of pre-assembling bits of code with .long,
> in order to allow a file to be built with wrong -march= flags, and I
> would favour migrating away from this where possible ... but I
> accept
> it's a pragmatic solution to a problem for which gcc/binutils
> provide
> no good alternative.
>
How about C files where 'wfi' used using inline assembly.
Can we also specify the " -march=" for the C files as well ?

Regards,
Santosh
