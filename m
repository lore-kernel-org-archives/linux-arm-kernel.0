From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 12 Oct 2015 19:10:10 +0200
Subject: [PATCH] pxa: remove incorrect __init annotation on
 pxa27x_set_pwrmode
In-Reply-To: <11408970.yetkS1BjHr@wuerfel> (Arnd Bergmann's message of "Mon,
 12 Oct 2015 15:46:08 +0200")
References: <5287252.pkh9x0t1Y6@wuerfel> <11408970.yetkS1BjHr@wuerfel>
Message-ID: <874mhw6mj1.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The z2 machine calls pxa27x_set_pwrmode() in order to power off
> the machine, but this function gets discarded early at boot because
> it is marked __init, as pointed out by kbuild:
>
> WARNING: vmlinux.o(.text+0x145c4): Section mismatch in reference from the function z2_power_off() to the function .init.text:pxa27x_set_pwrmode()
> The function z2_power_off() references
> the function __init pxa27x_set_pwrmode().
> This is often because z2_power_off lacks a __init
> annotation or the annotation of pxa27x_set_pwrmode is wrong.
>
> This removes the __init section modifier to fix rebooting and the
> build error.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ba4a90a6d86a ("ARM: pxa/z2: fix building error of pxa27x_cpu_suspend() no longer available")
> ---
> This is a fix for an old bug, I'd just put it into 4.4
>
> It showed up now because section mismatches now produce errors instead
> of warnings.

Hi Arnd,

I already have this queued for 4.4 from Thierry's patch in :
  http://www.spinics.net/lists/arm-kernel/msg449414.html

Yet your patch is more complete, as it deals also with the header in pxa27x.h
and has the fixes tag.

Now I'm wondering if I should enhance Thierry's patch with yours and keeping
your signoff with your permission, or drop Thierry's one to replace by yours (I
don't know if it's sane behavior to drop an already queued patch ...)

Cheers.

--
Robert
