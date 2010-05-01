From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 18:50:50 -0700
Subject: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <20100501013751.GL29604@atomide.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203349.25812.64659.stgit@baageli.muru.com>
	<87sk6cirt0.fsf@deeprootsystems.com>
	<20100430210216.GI29604@atomide.com>
	<87vdb8hc2d.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
	<87y6g4d2ic.fsf@deeprootsystems.com>
	<20100430233002.GJ29604@atomide.com>
	<87sk6c8osn.fsf@deeprootsystems.com>
	<20100501013751.GL29604@atomide.com>
Message-ID: <20100501015050.GM29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100430 18:33]:
> 
> So far only tested on n900, will give it a try also on zoom3 after
> updating the zoom3 related patch.

And here's the updated zoom debug_ll patch, seems to work.
 
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -20,27 +20,22 @@
>  #include <linux/types.h>
>  #include <linux/serial_reg.h>
>  
> +#include <asm/memory.h>
> +#include <asm/io.h>
>  #include <asm/mach-types.h>
>  
>  #include <plat/serial.h>

BTW, the include of asm/io.h is not needed, I'll remove that.

Regards,

Tony
