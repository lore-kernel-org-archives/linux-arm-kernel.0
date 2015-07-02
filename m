From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Jul 2015 11:55:39 +0100
Subject: [PATCH] ARM: psci: boot_secondary: replace __pa with virt_to_idmap
In-Reply-To: <20150702103930.GQ7557@n2100.arm.linux.org.uk>
References: <1435661062-4127-1-git-send-email-grygorii.strashko@ti.com>
 <20150630161836.GC28372@leverpostej>
 <20150630202537.GI7557@n2100.arm.linux.org.uk>
 <20150702102937.GA13036@leverpostej>
 <20150702103930.GQ7557@n2100.arm.linux.org.uk>
Message-ID: <20150702105539.GB13036@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I could retain the struct and packing functions for the two cases you
> > mention, but it seemed somewhat misleading. I'll see if I can figure out
> > something better than a raw hex value.
> 
> What's wrong with a few #defines for this?

Nothing.

> It obviously is well enough defined in existing pre-v1.0
> implementations as there is an existing structure to the parameter.
> 
> Can we not do something like:
> 
> #define PSCI_POWER_STATE_ID(x)			(x)
> #define PSCI_POWER_STATE_TYPE_POWER_DOWN	0x000100000
> #define PSCI_POWER_STATE_AFFINITY_LEVEL(x)	((x) << 24)

Looks good.

We already have some constants defined in a UAPI header, so I'll see
about reusing those.

Thanks,
Mark.
