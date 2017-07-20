From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Thu, 20 Jul 2017 10:48:31 +0300
Subject: [PATCH 0/9] Bringing Asus TF300T support to mainline
In-Reply-To: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <a4149270-561a-4190-4c4e-c164bd91446e@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.07.2017 03:29, Micha? Miros?aw wrote:
> Here is a suprisingly small set of patches that enable Asus TF300T tablet
> to boot and have all cores available. TF300T is one of a consumer devices
> based on NVidia's Cardhu reference tablet.

This is very cool! How did you debug it, or did it work on the first 
try? :) I have a TF201 myself, probably quite similar to this, might be 
worth a try.

>
> This series is an arch-dependent part. TF parts were extracted from ASUS's
> GPL code dump.  The rest being driver code - a work in progress - is
> available in branch tf300t at:
>
>         https://rere.qmqm.pl/git/linux

This URL doesn't work for me at least in the browser, but 
https://rere.qmqm.pl/git/?p=linux;a=summary works.

Regarding the USB device mode - yes, there are several drivers for 
roughly the same hardware. It would be good to get both host and device 
mode with the same driver so that we could have OTG support.

Cheers,
Mikko

>
> Best Regards,
> Micha? Miros?aw
>
> ---
>
> Micha? Miros?aw (9):
>   ARM: enable secure platform-only erratas
>   arm: cache-l2x0: remove duplicate warning
>   arm: cache-l2x0: share l2x0_base
>   ARM: trusted_foundations: enable L2x0 cache via firmware_ops
>   ARM: trusted_foundations: announce firmware version
>   ARM: init: update secondary_data register documentation
>   ARM: tegra: enable cache via TF
>   ARM: tegra: avoid touching Secure registers in reset handler
>   ARM: tegra: fix sleeping while atomic in CPU idle
>
>  arch/arm/Kconfig                           | 20 +++++++---
>  arch/arm/firmware/trusted_foundations.c    | 63 +++++++++++++++++++++++++++++-
>  arch/arm/include/asm/hardware/cache-l2x0.h |  6 ++-
>  arch/arm/kernel/head.S                     |  4 +-
>  arch/arm/mach-tegra/reset-handler.S        | 27 ++++++++++++-
>  arch/arm/mm/cache-l2x0-pmu.c               |  8 +---
>  arch/arm/mm/cache-l2x0.c                   | 26 ++++++------
>  drivers/soc/tegra/pmc.c                    |  2 -
>  8 files changed, 125 insertions(+), 31 deletions(-)
>
