From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 28 Jan 2015 23:33:15 +0100
Subject: [PATCH v2 0/8] ARM: Conexant Digicolor CX92755 SoC support
In-Reply-To: <5966468.GiJYdzCvnt@wuerfel>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <5966468.GiJYdzCvnt@wuerfel>
Message-ID: <1422484395.3621.73.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-01-08 at 23:46 +0100, Arnd Bergmann wrote:
> Once there are no more review comments, please submit the first three
> patches to arm at kernel.org, and send the other patches as separate
> series to the respective maintainers for irqchip and clocksource.

I found this message while looking into CONFIG_ARCH_DIGICOLOR. That
Kconfig macro entered linux-next in next-20150128. But there's no
Kconfig symbol ARCH_DIGICOLOR yet in linux-next.

As you might be aware I try to check each linux-next release for Kconfig
oddities. One of the oddities I tend _not_ to report are things like
this. That is, SoC's, MFD's, or whatever, were specific drivers can get
merged before the core functionality. In this case the irqchip driver
got merged into linux-next while the core ARCH_DIGICOLOR code is still
pending. And you happen to be involved with quite a bit of code in areas
like that. 

Pre-merges like this appear unavoidable (ie, other workflows would be
more trouble for the people involved). But what would be a good moment
to still raise an issue like this? Just to make sure things don't fall
through the cracks. As in: "this driver got merged into mainline but do
you know you can't yet build it?". Perhaps with each -rc1?


Paul Bolle
