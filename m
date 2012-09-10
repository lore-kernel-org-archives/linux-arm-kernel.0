From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Sep 2012 17:43:28 +0100
Subject: [PATCH v3 08/31] arm64: CPU support
In-Reply-To: <201209071924.38430.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
 <201209071924.38430.arnd@arndb.de>
Message-ID: <20120910164328.GA8238@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 08:24:38PM +0100, Arnd Bergmann wrote:
> On Friday 07 September 2012, Catalin Marinas wrote:
> > +#include <asm/cputable.h>
> > +
> > +extern unsigned long __cpu_setup(void);
> > +
> > +struct cpu_info __initdata cpu_table[] = {
> > +	{
> > +		.cpu_id_val	= 0x000f0000,
> > +		.cpu_id_mask	= 0x000f0000,
> > +		.cpu_name	= "AArch64 Processor",
> > +		.cpu_setup	= __cpu_setup,
> > +	},
> > +	{ /* Empty */ },
> > +};
> 
> > +#define MAIR(attr, mt)	((attr) << ((mt) * 8))
> > +
> > +ENTRY(cpu_proc_init)
> > +	ret
> > +ENDPROC(cpu_proc_init)
> > +
> > +ENTRY(cpu_proc_fin)
> > +	ret
> > +ENDPROC(cpu_proc_fin)
> 
> 
> These seem to be leftovers from multi-cpu support that can be removed.

Actually cpu_proc_fin() needs to be implemented for turning the caches
off during setup_restart(). But I'll rename it to something more
meaningful like cpu_cache_off(). The other can go.

-- 
Catalin
