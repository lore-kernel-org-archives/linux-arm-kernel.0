From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Jan 2015 08:44:55 -0800
Subject: ARM: OMAP3: MACH_OMAP3517EVM?
In-Reply-To: <1421744597.9655.92.camel@x220>
References: <1421744597.9655.92.camel@x220>
Message-ID: <20150120164455.GD7718@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [150120 01:06]:
> Tony,
> 
> Your commit 4d62dbda8561 ("ARM: OMAP3: Remove legacy support for
> am3517-evm") is included in today's linux-next (ie, next-20150120). I
> noticed because a script I use to check linux-next spotted a problem
> caused by it.

OK thanks for spotting that.
 
> See, your commit removes the Kconfig symbol MACH_OMAP3517EVM. But
> there's still a reference to that symbol in sound/soc/omap/Kconfig. This
> means that in linux-next a symbol, SND_OMAP_SOC_AM3517EVM, cannot be set
> anymore.
> 
> I assume a patch that address this (either by removing
> SND_OMAP_SOC_AM3517EVM or by updating its dependencies) is queued
> somewhere. Is that correct?

Not yet, I missed that part sorry. I'll add back the Kconfig symbol.
I'll rather do the removal in smaller steps, and first remove the
3517 related board-*.c file before messing with the legacy drivers.

Regards,

Tony
