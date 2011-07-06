From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 06 Jul 2011 11:05:51 +0100
Subject: [PATCH V2 0/6] arm_smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <1309892440-3260-1-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <4E14337F.1050101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vitaly,

On 05/07/11 20:00, Vitaly Kuzmichev wrote:
> The series of patches fixes various bugs in ARM MPCORE watchdog setup.
> They also introduce some changes in common ARM_SMP_TWD timer setup code.
> The PATCH 2/6 adds an exported function to obtain twd timer rate in
> mpcore_wdt. However, this solution might be unacceptable, and the
> better is to copy calibration loop and clk_get_rate calling to mpcore_wdt.

My take on this is that the calibration loop should simply be killed
once Colin's patch using the "smp_twd" clock is merged and relevant
platforms updated. Once this is done, the watchdog driver should use the
clock directly, without exporting a symbol.

> The series of patches is based on arm-platforms.git/local_timers_as_devices
> branch since it looks like that it is going to be merged into the mainline.

Be careful here. This branch is a work in progress, likely to change
very quickly, contains code that has not been posted to the ML yet, and
will probably eat your pet for breakfast. As far as mainline merging is
concerned, there is still a long way to go (see the GIC consolidation
patches, on which the local_timers_as_devices branch relies).

> V1 series was not discussed widely because I forgot to add all necessary
> maintainers in Cc.

Thanks for that.

	M.
-- 
Jazz is not dead. It just smells funny...
