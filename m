From: msalter@redhat.com (Mark Salter)
Date: Fri, 10 Jan 2014 15:52:02 -0500
Subject: [PATCH v3 4/6] arm: add early_ioremap support
In-Reply-To: <52D05ABD.30904@codeaurora.org>
References: <1389325833-16535-1-git-send-email-msalter@redhat.com>
 <1389325833-16535-5-git-send-email-msalter@redhat.com>
 <52D05ABD.30904@codeaurora.org>
Message-ID: <1389387122.2591.96.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-01-10 at 12:40 -0800, Stephen Boyd wrote:
> Just some minor nitpicks
> 
> On 01/09/14 19:50, Mark Salter wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index c1f1a7e..78a79a6a 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1842,6 +1842,17 @@ config UACCESS_WITH_MEMCPY
> >  	  However, if the CPU data cache is using a write-allocate mode,
> >  	  this option is unlikely to provide any performance gain.
> >  
> > +config EARLY_IOREMAP
> > +	depends on MMU
> > +	bool "Provide early_ioremap() support for kernel initialization."
> 
> Please drop the full stop.
> 
> > +	select GENERIC_EARLY_IOREMAP
> > +	help
> > +	  Provide a mechanism for kernel initialisation code to temporarily
> > +	  map, in a highmem-agnostic way, memory pages in before ioremap()
> > +	  and friends are available (before paging_init() has run). It uses
> > +	  the same virtual memory range as kmap so all early mappings must
> > +	  be unapped before paging_init() is called.
> 
> s/unapped/unmapped/
> 

Will do. Thanks!
