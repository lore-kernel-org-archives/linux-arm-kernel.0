From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 12:04:44 -0600
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
Message-ID: <51E439BC.9030608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2013 03:23 AM, Joseph Lo wrote:
> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> this state.

I tried applying this patch, your series "[PATCH V3 0/3] ARM: tegra114:
cpuidle: add power down state", and your series "[PATCH V2 00/11] ARM:
tegra114: add support for system suspend", all on top of v3.11-rc1.

On Dalmore, the new cpuidle mode /appears/ to work (I see increasing
values in the sysfs cpuidle "usage" file for all defined cpuidle
states), but I don't see the "CPU VDD off" LED light up; I'm not
convinced that the CPU is actually being powered off in the idle mode.

With these patches applies, Harmony acts very strangely. After
hot-unplug and re-plug of CPU1, the system is hung or almost hung. The
patches appear to reduce the amount of time CPU VDD is off judging by
the LEDs. The patches might cause issues with system suspend too, but
I'm not 100% sure.

As such, I haven't applied any of these. Can you please test boards for
all of Tegra20/30/114, and validate that on Dalmore the CPU power is
actually being turned off, and report back? Thanks.
