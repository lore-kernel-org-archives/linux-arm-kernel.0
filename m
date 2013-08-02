From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Fri, 02 Aug 2013 10:32:40 +0100
Subject: [PATCH v2 0/3] ARM/ARM64 architected timer updates
In-Reply-To: <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <51FB7CB8.6080103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 22/07/13 12:21, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This patch series adds support to configure the rate and enable the event
> stream for architected timer. Since the timer control register is reset to
> zero on warm boot, CPU PM notifier is added to re-initialse it.
> 
This series is required to support TC2 cpuidle.
It will be good if you can review and get this in for v3.12

Regards,
Sudeep

> Changes v1->v2:
> 1. Saved event stream divider value on cold reset path and re-used it
>    in CPU PM notifier instead of calculating every time.
> 2. Rebased on v3.11-rc2(to avoid conflicts with __cpuinit* deletion)
> 3. Dropped "ARM/ARM64: arch_timer: remove __cpuinit attribute for
>    arch_counter_set_user_access"(already done as part of __cpuinit*
>    deletion)
> 
> Regards,
> Sudeep
> 
> 
> Sudeep KarkadaNagesha (2):
>   ARM: arch_timer: add macros for bits in control register
>   drivers: clocksource: add CPU PM notifier for ARM architected timer
> 
> Will Deacon (1):
>   drivers: clocksource: configure event stream for ARM arch timer
> 
>  arch/arm/include/asm/arch_timer.h    | 10 ++++++--
>  arch/arm64/include/asm/arch_timer.h  | 12 +++++++---
>  drivers/clocksource/arm_arch_timer.c | 45 +++++++++++++++++++++++++++++++++++-
>  include/clocksource/arm_arch_timer.h | 10 ++++++++
>  4 files changed, 71 insertions(+), 6 deletions(-)
> 
