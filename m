From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 14 Jan 2011 10:45:08 -0800
Subject: [PATCH] TWD: enable one-shot mode
In-Reply-To: <20110111115209.GA12781@n2100.arm.linux.org.uk>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
	<4D2BE6C4.4040806@codeaurora.org>
	<20110111115209.GA12781@n2100.arm.linux.org.uk>
Message-ID: <4D3099B4.40900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2011 03:52 AM, Russell King - ARM Linux wrote:
> On Mon, Jan 10, 2011 at 09:12:36PM -0800, Stephen Boyd wrote:
>>
>> I see this patch was already tested and merged but can you elaborate on
>> why this was done? From what I understand, NOHZ selects one-shot (like
>> is done in this patch), so why don't the machines with a TWD choose NOHZ
>> or high res timers?
>
> You're right - so it's not actually required.  It should probably be
> reverted, though it does no damage...

Now I'm wondering why there are other 'select TICK_ONESHOT' lines in
arch/arm/Kconfig. Can we just remove them all? Otherwise it feels like
we're making it confusing for others later on.

----->8---[cut here]----8<-----
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e2f8011..7750a78 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -532,7 +532,6 @@ config ARCH_MMP
        select CLKDEV_LOOKUP
        select GENERIC_CLOCKEVENTS
        select HAVE_SCHED_CLOCK
-       select TICK_ONESHOT
        select PLAT_PXA
        select SPARSE_IRQ
        help
@@ -613,7 +612,6 @@ config ARCH_PXA
        select ARCH_REQUIRE_GPIOLIB
        select GENERIC_CLOCKEVENTS
        select HAVE_SCHED_CLOCK
-       select TICK_ONESHOT
        select PLAT_PXA
        select SPARSE_IRQ
        help
@@ -668,7 +666,6 @@ config ARCH_SA1100
        select GENERIC_CLOCKEVENTS
        select HAVE_CLK
        select HAVE_SCHED_CLOCK
-       select TICK_ONESHOT
        select ARCH_REQUIRE_GPIOLIB
        help
          Support for StrongARM 11x0 based boards.
@@ -1300,7 +1297,6 @@ config HAVE_ARM_SCU
 config HAVE_ARM_TWD
        bool
        depends on SMP
-       select TICK_ONESHOT
        help
          This options enables support for the ARM timer and watchdog unit

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
