From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 18 Jan 2012 18:36:57 +0000
Subject: [PATCH v2 1/3] ARM: davinci: convert to common sched_clock()
 implementation
In-Reply-To: <1326903292-15794-2-git-send-email-marc.zyngier@arm.com>
References: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
 <1326903292-15794-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B631794A9F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Jan 18, 2012 at 21:44:50, Marc Zyngier wrote:
> Davinci has its own sched_clock() implementation, which gets in the
> way of a single zImage. Moving to the common sched_clock framework
> makes the code slightly cleaner.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested this on DaVinci DM365 and works well.

> diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
> index e1969ce..187fcda 100644
> --- a/arch/arm/mach-davinci/time.c
> +++ b/arch/arm/mach-davinci/time.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  
>  #include <mach/hardware.h>
> +#include <asm/sched_clock.h>
>  #include <asm/mach/irq.h>
>  #include <asm/mach/time.h>
>  #include <mach/cputype.h>

I did not like the fact that the asm/ and mach/ headers
are intermixed in this file so I created a patch to
fix that while I was doing the common sched_clock() conversion.

http://www.spinics.net/lists/arm-kernel/msg153506.html

Can you please rebase your patch on that?

If you are planning to take this from outside of DaVinci tree,
feel free to add my:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Else, let me know and I will pick it.

Thanks,
Sekhar
