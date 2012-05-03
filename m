From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 3 May 2012 21:23:55 +0200
Subject: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
In-Reply-To: <20120503144645.6390.62303.sendpatchset@w520>
References: <20120503144645.6390.62303.sendpatchset@w520>
Message-ID: <201205032123.55535.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 03, 2012, Magnus Damm wrote:
> mach-shmobile: Emma Mobile EV2 - first shot
> 
> [PATCH 01/02] mach-shmobile: Emma Mobile EV2 SoC base support
> [PATCH 02/02] mach-shmobile: KZM9D board prototype support
> 
> This series adds experimental Emma Mobile EV2 support to
> mach-shmobile. Yet another dual core Cortex-A9 SoC.
> 
> At this point only serial and timer is supported. Future work
> includes GPIO, network device, SMP and DT support. If possible
> it would be nice to use the common clocks on this platform.
> 
> To boot this on actual hardware you also need the following:
> "[PATCH] serial8250-em: Emma Mobile UART driver V2"
> "[PATCH] clocksource: em_sti: Emma Mobile STI driver"
> 
> Any reason to not put this in mach-shmobile?
> 
> Partially-signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Does unfortunately not apply cleanly to the renesas
>  git repository,

Well, this sounds like a reason.

>  so we need to figure out how to let
>  this coexist with the new boards...

Surely.

Thanks,
Rafael


>  arch/arm/mach-shmobile/Kconfig               |    9 +
>  arch/arm/mach-shmobile/Makefile              |    2 
>  arch/arm/mach-shmobile/board-kzm9d.c         |   44 +++++
>  arch/arm/mach-shmobile/clock-emev2.c         |  206 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    6 
>  arch/arm/mach-shmobile/intc-emev2.c          |   36 ++++
>  arch/arm/mach-shmobile/setup-emev2.c         |  187 +++++++++++++++++++++++
>  7 files changed, 490 insertions(+)
> 
> 
