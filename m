From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 1 May 2012 10:37:32 -0500
Subject: [PATCH 0/5] ARM: OMAP2+: PM: implement a caching mechanism on
 the power domains state registers
In-Reply-To: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Message-ID: <4FA0033C.3020709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On 05/01/2012 08:07 AM, jean.pihet at newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> The OMAP3 PRCM registers accesses are known to be slow, with a PRCM register
> read taking up to 12-14us depending on the OPP.
> 
> This patch adds a caching mechanism on the power domains state registers.
> When the cache is cold or has been invalidated a register access is
> performed, otherwise the register value is retrieved from the registers
> cache.
> The API is made of read and write functions for fields in the cache, as well
> as an invalidate and helper functions to invalidate parts of the cache
> contents (i.e. previous, current power states and all fields in the cache).
> The power domain code is converted to use the API to read and write the
> previous, current and next states for the power domains states, logical
> and memory states.
> The PM debug code also uses the caching API instead of the internal
> pwrdm->state variable.
> 
> Using the caching mechanism optimizes the performance of the system in the
> transitions to and from the low power states.

Looks interesting!

A couple high level questions for you ...

1. Do you intend to cache registers that are updated by hardware?
2. If yes to 1, should there be some "cache debug mode" we can enable to
test the cache and registers are in sync for testing?

Cheers
Jon
