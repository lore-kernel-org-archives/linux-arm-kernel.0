From: zql@glomationinc.com (zql at glomationinc.com)
Date: Thu, 27 May 2010 09:39:47 -0500 (CDT)
Subject: Problem with at91_mci and AT91RM9200
In-Reply-To: <1274966669.2465.105.camel@arcturus>
References: <1274966669.2465.105.camel@arcturus>
Message-ID: <52497.72.68.115.39.1274971187.squirrel@webmail.hostgator.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Recently I bough a cheap board with Atmel AT92RM9200 CPU and
> preinstalled patched kernel 2.6.21 to play with. Board is NGX Blueboard
> ARM9 and it's based (almost a 1:1 copy) on ECB_AT91
> ( http://en.wikipedia.org/wiki/ECB_AT91 ) which is supported in kernel.
> I was able to do basic things with it (boot from SD, Ethernet).
>
> I compiled newest kernel (2.6.33.4 and 2.6.32 with at91 patches
> http://www.at91.com/linux4sam/bin/view/Linux4SAM/LinuxKernel#AT91_Linux_kernel_sources_summar
> )
> which boots but fails to detect SD Card (Sandisk microSD 2 GB through SD
> adapter). A the end there's a debugging output (stripped, full:
> http://liku.ayz.pl/at91mmc ).
>
> I started to look for a cause of the problem but asking here may save me
> some time:
> * does anybody still, successfully, uses this CPU and newest at_mci
> driver?
> * What might be the cause of this error?
> * Perhaps CPU is it too obsolete and I should stay with old kernel
> (+errata has a lot of problems for mci subsystem)?
>
> What I have already tried:
> * I checked hardware connections between card socket and CPU (as well as
> other possible hardware causes),
> * tried at91 and atmel mci driver, on atmel mci driver nothing happens,
> * tried different kernel versions (patched .32 and unpatched .33),
> * started to patch new kernel with old patches from ECB but whole mci
> subsystem changed.
>
> Regards,
> Lukasz.
>

The MMC/SD card driver is broken for Atmel 9G20 as well since 2.6.30.  It
no longer detect cards that used to work on 2.6.27.
