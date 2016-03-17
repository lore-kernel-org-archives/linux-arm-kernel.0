From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 17 Mar 2016 10:07:30 -0500
Subject: [PATCH v4 0/5] acpi, clocksource, kvm: add GTDT and ARM
 memory-mapped timer support
In-Reply-To: <1458199917-30699-1-git-send-email-fu.wei@linaro.org>
References: <1458199917-30699-1-git-send-email-fu.wei@linaro.org>
Message-ID: <56EAC832.6070203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>      (1)Move some enums and marcos to header file for arm_arch_timer,
>      improve the pr_* code by defining "pr_fmt(fmt)" in arm_arch_timer.c
>
>      (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>      Parse all kinds of timer in GTDT table of ACPI:arch timer,
>      memory-mapped timer and SBSA Generic Watchdog timer.
>      This driver can help to simplify all the relevant timer drivers,
>      and separate all the ACPI GTDT knowledge from them.
>
>      (3)Simplify ACPI code for arch timer in arm_arch_timer.c
>
>      (4)Add memory-mapped timer support in arm_arch_timer.c

The SBSA watchdog driver is already in watchdog-next and will be merged 
into 4.6.  These five patches are necessary for the watchdog driver to 
probe on an ACPI system.

I'm guessing since that v4 was posted in the middle of the 4.6 merge 
window, that these patches won't make it and we'll have to wait until 
4.7 (at the earliest)?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
