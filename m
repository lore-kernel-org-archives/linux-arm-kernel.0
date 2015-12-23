From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Dec 2015 13:29:12 -0800
Subject: [PATCH v2] ARM: mm: flip priority of CONFIG_DEBUG_RODATA
In-Reply-To: <567B04AB.6010906@redhat.com>
References: <20151202202725.GA794@www.outflux.net>
 <20151223195129.GP2793@atomide.com> <567B04AB.6010906@redhat.com>
Message-ID: <20151223212911.GR2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Laura Abbott <labbott@redhat.com> [151223 12:31]:
> 
> Looks like a case similar to Geert's
> 
>         adr     r7, kick_counter
> wait_dll_lock_timed:
>         ldr     r4, wait_dll_lock_counter
>         add     r4, r4, #1
>         str     r4, [r7, #wait_dll_lock_counter - kick_counter]
>         ldr     r4, sdrc_dlla_status
>         /* Wait 20uS for lock */
>         mov     r6, #8
> 
> 
> kick_counter and wait_dll_lock_counter are in the text section which is marked read only.
> They need to be moved to the data section along with a few other variables from what I
> can tell (maybe those are read only?).

Thanks for looking, yeah so it seem.

> I suspect this is going to be a common issue with suspend/resume code paths since those
> are hand written assembly.

Yes I suspect we have quite a few cases like this.

Regards,

Tony
