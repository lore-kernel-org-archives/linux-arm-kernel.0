From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 20 Jan 2015 10:03:17 +0100
Subject: ARM: OMAP3: MACH_OMAP3517EVM?
Message-ID: <1421744597.9655.92.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Your commit 4d62dbda8561 ("ARM: OMAP3: Remove legacy support for
am3517-evm") is included in today's linux-next (ie, next-20150120). I
noticed because a script I use to check linux-next spotted a problem
caused by it.

See, your commit removes the Kconfig symbol MACH_OMAP3517EVM. But
there's still a reference to that symbol in sound/soc/omap/Kconfig. This
means that in linux-next a symbol, SND_OMAP_SOC_AM3517EVM, cannot be set
anymore.

I assume a patch that address this (either by removing
SND_OMAP_SOC_AM3517EVM or by updating its dependencies) is queued
somewhere. Is that correct?

Thanks,


Paul Bolle
