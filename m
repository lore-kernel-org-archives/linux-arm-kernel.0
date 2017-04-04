From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 4 Apr 2017 15:39:04 -0500
Subject: [PATCH v23 00/11] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Message-ID: <58003cb9-e190-925d-f5af-947159cbd040@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2017 12:50 PM, fu.wei at linaro.org wrote:
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Introduce a MMIO CNTFRQ helper.
>         2. separate out device-tree code from arch_timer_detect_rate
>         3. remove arch_timer_detect_rate use arch_timer_*get_cntfrq directly
>         4. Refactor arch_timer_needs_probing, and move it into DT init call
>         5. Introduce some new structs and refactor the MMIO timer init code
>         for reusing some common code.
> 
>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
> 
>     (3)Simplify ACPI code for arm_arch_timer
> 
>     (4)Add GTDT support for ARM memory-mapped timer.
> 
> This patchset has been tested on the following platforms with ACPI enabled:
>     (1)ARM Foundation v8 model
> 
> Changelog:
> v23: https://lkml.org/lkml/2017/3/31/

v23:

Tested-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
