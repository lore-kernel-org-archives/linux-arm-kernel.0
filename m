From: digetx@gmail.com (Dmitry Osipenko)
Date: Sun, 11 Nov 2018 15:42:58 +0300
Subject: [PATCH 0/3] ARM: enable cache via Trusted Foundations firmware
In-Reply-To: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
Message-ID: <a84ef2fc-fe95-f4ff-f499-a8faf8d86a75@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.11.2018 0:02, Micha? Miros?aw wrote:
> This set enables platforms using Trusted Foundations firmware to use
> their L2 cache. L2 cache can be enabled only by calling the firmware.
> 
> Micha? Miros?aw (3):
>   ARM: cache-l2x0: share l2x0_base with PMU code
>   ARM: trusted_foundations: enable L2x0 cache via firmware_ops
>   ARM: trusted_foundations: announce firmware version
> 
>  arch/arm/firmware/trusted_foundations.c    | 67 +++++++++++++++++++++-
>  arch/arm/include/asm/hardware/cache-l2x0.h |  6 +-
>  arch/arm/mm/cache-l2x0-pmu.c               |  9 +--
>  arch/arm/mm/cache-l2x0.c                   | 14 ++++-
>  4 files changed, 82 insertions(+), 14 deletions(-)
> 

Hello Micha?,

Very nice to see that you are keeping to work on it! Couple months ago I posted patches that add a full-featured Trusted Foundations support on Tegra30 [0] (including suspend-resume, thumb2 kernel, handling CONFIG_CACHE_L2X0=n), unfortunately they didn't get any attention yet. Could you please take a look and try out [0]? I've got everything working without touching arch/arm/mm/cache-l2x0* at all. Would be awesome if we could cooperate the efforts somehow, maybe that will also help to get more attention from the maintainers.

[0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=63339
