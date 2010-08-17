From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Aug 2010 14:20:11 +0300
Subject: [PATCH 2/4] ARM: Allow optional UP processor functions for SMP
	kernels
In-Reply-To: <20100817110857.GB20325@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100817105325.19061.93324.stgit@baageli.muru.com>
	<20100817110857.GB20325@n2100.arm.linux.org.uk>
Message-ID: <20100817112011.GG12184@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100817 14:01]:
> On Tue, Aug 17, 2010 at 01:53:25PM +0300, Tony Lindgren wrote:
> 
> > +	if (list->proc_up)
> > +		processor = *list->proc_up;
> > +
> > +	if (list->tlb_up)
> > +		cpu_tlb = *list->tlb_up;
> > +
> > +	if (list->cache_up)
> > +		cpu_cache = *list->cache_up;
> 
> I don't think this is a good approach at all - most of the assembly
> is identical and I'm sure there's a much better approach to fixing
> these things up.

We could simplify it if we tried to detect SMP kernel running
on UP hardware early on and then select the UP vs SMP code as
needed.

Regards,

Tony
