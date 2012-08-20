From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Aug 2012 17:00:54 +0100
Subject: [PATCH v2 08/31] arm64: CPU support
In-Reply-To: <201208151356.05416.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-9-git-send-email-catalin.marinas@arm.com>
 <201208151356.05416.arnd@arndb.de>
Message-ID: <20120820160053.GB912@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 02:56:05PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/procinfo.h
...
> > +struct proc_info_list {
> > +	unsigned int		cpu_val;
> > +	unsigned int		cpu_mask;
> > +	unsigned long		__cpu_flush;		/* used by head.S */
> > +	const char		*cpu_name;
> > +};
> > +
> > +#else	/* __KERNEL__ */
> > +#include <asm/elf.h>
> > +#warning "Please include asm/elf.h instead"
> > +#endif	/* __KERNEL__ */
> > +#endif
> 
> I think you forgot to remove this file when you removed MULTI_CPU.

proc_info_list() structure is still used just for the CPU name and setup
function (e.g. we need to apply errata workaround on a certain CPU). But
as Olof suggested, I better move all this to a cputable.c file.

-- 
Catalin
