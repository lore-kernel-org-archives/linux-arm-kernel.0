From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 3 Sep 2014 09:09:06 -0500
Subject: [PATCH 0/4] arm_arch_timer: VDSO preparation, code consolidation
In-Reply-To: <1408743797-7648-1-git-send-email-nathan_lynch@mentor.com>
References: <1408743797-7648-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <54072102.1020605@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2014 04:43 PM, Nathan Lynch wrote:
> This series contains the necessary changes to allow architected timer
> access from user-space on 32-bit ARM.  This allows the VDSO to support
> high resolution timestamps for clock_gettime and gettimeofday.  This
> also merges substantially similar code from arm and arm64 into the
> core arm_arch_timer driver.
> 
> These patches have been carried as part of the ARM VDSO patch set over
> the last several months, but I am splitting them out here as I assume
> they should go through the clocksource maintainer.
> 
> Nathan Lynch (4):
>   clocksource: arm_arch_timer: change clocksource name if CP15
>     unavailable
>   clocksource: arm_arch_timer: enable counter access for 32-bit ARM
>   ARM: arch_timer: remove unused functions
>   arm64: arch_timer: remove unused functions
> 
>  arch/arm/include/asm/arch_timer.h    | 25 -------------------
>  arch/arm64/include/asm/arch_timer.h  | 31 -----------------------
>  drivers/clocksource/arm_arch_timer.c | 48 +++++++++++++++++++++++++++++++++---
>  3 files changed, 44 insertions(+), 60 deletions(-)

Daniel, do you plan to take this series for 3.18?
