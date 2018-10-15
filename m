From: digetx@gmail.com (Dmitry Osipenko)
Date: Mon, 15 Oct 2018 15:34:57 +0300
Subject: [PATCH v3 0/8] Support Trusted Foundations firmware on Tegra30
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Message-ID: <91e4af24-7be7-2dbc-577b-56a852cc21ff@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/30/18 9:04 PM, Dmitry Osipenko wrote:
> Hello,
> 
> All consumer-grade Tegra30 devices, like Nexus 7 tablet; Ouya console and
> others, use Trusted Foundations firmware that doesn't allow CPU to access
> secure registers directly from the Linux kernel, these accesses shall be
> done via the firmware calls. This patch-series adds a full-featured support
> of the Trusted Foundations firmware that opens the door for supporting of
> various Tegra30-based devices in the upstream Linux kernel.
> 
> Changelog:
> 
> v3:	- Implemented suspend-resume support.
> 
> 	- Reworked arm/firmware/trusted_foundations.c a tad. Now cache
> 	  is getting properly initialized, cache enabling / disabling is
> 	  supported.
> 
> v2:
> 	- The "Don't apply CPU erratas in insecure mode" patch got some
> 	  cleanup, in particular resolved the messiness in
> 	  __tegra_cpu_reset_handler_data.
> 
> 	- Added a comment to tf_cache_write_sec(), justifying the warning
> 	  message.
> 
> Dmitry Osipenko (8):
>   ARM: trusted_foundations: Implement L2 cache initialization callback
>   ARM: trusted_foundations: Make prepare_idle call to take mode argument
>   ARM: trusted_foundations: Provide information about whether firmware
>     is registered
>   ARM: tegra: Setup L2 cache using Trusted Foundations firmware
>   ARM: tegra: Don't apply CPU erratas in insecure mode
>   ARM: tegra: Always boot CPU in ARM-mode
>   ARM: tegra: Support L2 cache maintenance done via firmware
>   ARM: tegra: Add firmware calls required for suspend-resume
> 
>  arch/arm/firmware/trusted_foundations.c    | 80 +++++++++++++++++++++-
>  arch/arm/include/asm/firmware.h            |  2 +-
>  arch/arm/include/asm/trusted_foundations.h | 13 ++++
>  arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
>  arch/arm/mach-tegra/pm.c                   | 43 ++++++++++++
>  arch/arm/mach-tegra/reset-handler.S        | 66 ++++++++++++++----
>  arch/arm/mach-tegra/reset.c                |  3 +
>  arch/arm/mach-tegra/reset.h                |  9 ++-
>  arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
>  arch/arm/mach-tegra/sleep.S                |  4 ++
>  arch/arm/mach-tegra/tegra.c                | 10 +++
>  11 files changed, 216 insertions(+), 21 deletions(-)
> 

ping
