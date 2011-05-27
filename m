From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 27 May 2011 10:26:40 +0200
Subject: [PATCH 0/4] ARM: smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <20110527082640.GC16394@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vitaly,

> From: Vitaly Kuzmichev <vkuzmichev@mvista.com>
> 
> The series of patches fixes various bugs in ARM MPCORE watchdog setup.
> They also introduce some changes in common SMP_TWD timer setup code.
> The PATCH 1/4 adds an exported function to obtain calibrated timer rate
> in mpcore_wdt. However, this solution might be unacceptable, so we may
> discuss another 2 variants:
>  1) use clock framework
>    This may require to fix all MPCORE boards clock implementations.
>  2) copy calibration loop to mpcore_wdt
>    However, this increases boot time.
> 
> 
> Vitaly Kuzmichev (4):
>   ARM: smp_twd: mpcore_wdt: Fix watchdog counter loading
>   ARM: smp_twd: Fix typo in twd_timer_rate printout
>   ARM: mpcore_wdt: Fix WDIOC_SETOPTIONS handling
>   ARM: mpcore_wdt: Fix timer mode setup
> 
>  arch/arm/include/asm/smp_twd.h |    7 +++++++
>  arch/arm/kernel/smp_twd.c      |    8 +++++++-
>  drivers/watchdog/mpcore_wdt.c  |   29 +++++++++++++++++++++--------
>  3 files changed, 35 insertions(+), 9 deletions(-)

What's the status on this? I don't recall having seen any answers from ARM community.

Kind regards,
Wim.
