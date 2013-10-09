From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 9 Oct 2013 08:29:21 +0200
Subject: [GIT PULL] clocksource: event stream on architected timers and
 tcb_clksrc misc changes
In-Reply-To: <5252C443.9070501@linaro.org>
References: <5252C443.9070501@linaro.org>
Message-ID: <20131009062921.GF7664@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> Hi Thomas, Ingo,
> 
> - Will Deacon and Sudeep KarkadaNagesha implemented the event stream for 
> architected timer. The event streams can be used to impose a timeout on 
> a wfe, to safeguard against any programming error in case an expected 
> event is not generated or even to implement wfe-based timeouts for 
> userspace locking implementations. Some files fall under the arm 
> maintainers' umbrella but those changes have been reviewed and acked by 
> the relevant people (Catalin Marinas and Olof Johansson).
> 
> - Boris Brezillon improved the tcb_clksrc driver by removing a 
> deprecated flag, checking return code values and using functions from 
> the common clock framework.
> 
> Thanks !
> 
>    -- Daniel
> 
> The following changes since commit 68e90740284c69292881cd38c7ece6f09a18a58f:
> 
>   Merge branch 'clockevents/3.13' of
> git://git.linaro.org/people/dlezcano/linux into timers/core
> (2013-10-03 07:57:02 +0200)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/dlezcano/linux.git clockevents/3.13
> 
> for you to fetch changes up to f51380a75652a4600b34ce384c4ff89ce0a15132:
> 
>   clocksource: tcb_clksrc: Remove IRQF_DISABLED (2013-10-03 16:28:40 +0200)
> 
> ----------------------------------------------------------------
> Boris BREZILLON (3):
>       clocksource: tcb_clksrc: Replace clk_enable/disable with
> clk_prepare_enable/disable_unprepare
>       clocksource: tcb_clksrc: Improve driver robustness
>       clocksource: tcb_clksrc: Remove IRQF_DISABLED
> 
> Daniel Lezcano (1):
>       Merge branch 'timer_evtstrm' of git://linux-arm.org/linux-skn
> into clockevents/3.13
> 
> Sudeep KarkadaNagesha (4):
>       ARM/ARM64: arch_timer: add macros for bits in control register
>       ARM: arch_timer: add support to configure and enable event stream
>       ARM64: arch_timer: add support to configure and enable event stream
>       drivers: clocksource: add CPU PM notifier for ARM architected timer
> 
> Will Deacon (1):
>       drivers: clocksource: add support for ARM architected timer
> event stream
> 
>  arch/arm/include/asm/arch_timer.h    |   36 +++++++++++++++++---
>  arch/arm/include/uapi/asm/hwcap.h    |    1 +
>  arch/arm/kernel/setup.c              |    1 +
>  arch/arm64/include/asm/arch_timer.h  |   42 +++++++++++++++++++----
>  arch/arm64/include/asm/hwcap.h       |   11 +++---
>  arch/arm64/include/uapi/asm/hwcap.h  |    1 +
>  arch/arm64/kernel/setup.c            |   11 ++++++
>  drivers/clocksource/Kconfig          |   15 +++++++++
>  drivers/clocksource/arm_arch_timer.c |   49 +++++++++++++++++++++++++++
>  drivers/clocksource/tcb_clksrc.c     |   61 ++++++++++++++++++++++++++++------
>  include/clocksource/arm_arch_timer.h |   10 ++++++
>  11 files changed, 211 insertions(+), 27 deletions(-)

Pulled into tip:timers/core, thanks Daniel!

	Ingo
