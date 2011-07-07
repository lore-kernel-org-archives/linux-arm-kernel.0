From: wim@iguana.be (Wim Van Sebroeck)
Date: Thu, 7 Jul 2011 14:46:27 +0200
Subject: [PATCH V3 0/4] ARM: smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <20110707124627.GQ29245@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vitaly,

> The series of patches fixes various bugs in ARM MPCORE watchdog setup.
> They also introduce some changes in common SMP_TWD timer setup code.
> The PATCH V3 2/4 adds an exported function to obtain twd timer rate in
> mpcore_wdt. It was decided that this solution is the best at this time,
> and later it will be removed while conversion smp_twd driver into
> the clocksource/arm_smp_twd as well as calibration loop will be replaced
> by smp_twd clock. The mpcore_wdt will also use clk interface instead.
> 
> In comparing with V2 series this (V3) is based on linux-2.6/master branch.
> Also the patches PATCH V2 5/6 and PATCH V2 6/6 were thrown out since they
> are useless with current swp_twd driver.
> Also it was decided to keep PATCH V2 3/6 as is due to upcoming restructuring
> of watchdog drivers, but added parentheses inside 'if' condition.
> 
> Vitaly Kuzmichev (4):
>   ARM: smp_twd: Fix typo in 'twd_timer_rate' printing
>   ARM: smp_twd: mpcore_wdt: Fix watchdog counter loading
>   ARM: mpcore_wdt: Fix WDIOC_SETOPTIONS handling
>   ARM: mpcore_wdt: Fix timer mode setup
> 
>  arch/arm/include/asm/smp_twd.h |    7 +++++++
>  arch/arm/kernel/smp_twd.c      |    9 ++++++++-
>  drivers/watchdog/mpcore_wdt.c  |   22 ++++++++++++++--------
>  3 files changed, 29 insertions(+), 9 deletions(-)

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.
