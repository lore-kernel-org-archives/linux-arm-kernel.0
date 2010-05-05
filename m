From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 May 2010 17:30:12 +0100
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
In-Reply-To: <20100505162345.GB3169@mvista.com>
References: <20100423144058.GA11637@ZenIV.linux.org.uk>
	<20100430163356.GV2619@mvista.com>
	<1272645511.22683.1.camel@e102109-lin.cambridge.arm.com>
	<20100503155900.GA26552@mvista.com>
	<1272986997.15948.11.camel@e102109-lin.cambridge.arm.com>
	<20100505162345.GB3169@mvista.com>
Message-ID: <20100505163012.GA17678@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 12:23:45PM -0400, George G. Davis wrote:
> So could we similarly we relax this "Prohibit ioremap() on kernel managed
> RAM" change for reserved pages?  Like so:
> 
> 	/*
> 	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
> 	 */
> 	if (WARN_ON(pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)))
> 		return NULL;
> 

Only once the rest of the solution gets implemented; making this change
on its own doesn't mean very much or have very much effect.
