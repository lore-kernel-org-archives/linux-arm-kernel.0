From: msalter@redhat.com (Mark Salter)
Date: Wed, 15 Jan 2014 21:13:04 -0500
Subject: [PATCH v3 4/6] arm: add early_ioremap support
In-Reply-To: <52D72883.3020500@codeaurora.org>
References: <1389325833-16535-1-git-send-email-msalter@redhat.com>
 <1389325833-16535-5-git-send-email-msalter@redhat.com>
 <52D72883.3020500@codeaurora.org>
Message-ID: <1389838384.1923.41.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-15 at 16:32 -0800, Laura Abbott wrote:
> On 1/9/2014 7:50 PM, Mark Salter wrote:
> ....
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 987a7f5..038fb75 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -36,6 +36,7 @@
> >   #include <asm/cpu.h>
> >   #include <asm/cputype.h>
> >   #include <asm/elf.h>
> > +#include <asm/io.h>
> >   #include <asm/procinfo.h>
> >   #include <asm/psci.h>
> >   #include <asm/sections.h>
> > @@ -887,6 +888,8 @@ void __init setup_arch(char **cmdline_p)
> >
> >   	parse_early_param();
> >
> > +	early_ioremap_init();
> > +
> >   	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
> >
> >   	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
> 
> Any chance we could do this even earlier, say right after 
> setup_processor? It would be nice to be able to do this while FDT 
> scanning (I have a use case in mind, potential patches are in the works)

It looks like that would work...
