From: khilman@ti.com (Kevin Hilman)
Date: Tue, 13 Dec 2011 15:49:00 -0800
Subject: [PATCH 4/6] OMAP3: cpuidle: next C-state decision depends on the
 PM QoS MPU and CORE constraints
In-Reply-To: <1323706701-6627-5-git-send-email-j-pihet@ti.com> (jean pihet's
 message of "Mon, 12 Dec 2011 17:18:19 +0100")
References: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
 <1323706701-6627-5-git-send-email-j-pihet@ti.com>
Message-ID: <87aa6wt4lv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> The MPU latency figures for cpuidle include the MPU itself and also
> the peripherals needed for the MPU to execute instructions (e.g.
> main memory, caches, IRQ controller, MMU etc). On OMAP3 those
> peripherals belong to the MPU and CORE power domains and so the
> cpuidle C-states are a combination of MPU and CORE states.
>
> This patch implements the relation between the cpuidle and per-
> device PM QoS frameworks in the OMAP3 specific idle callbacks.
>
> The chosen C-state shall satisfy the following conditions:
>  . the 'valid' field is enabled,
>  . it satisfies the enable_off_mode flag,
>  . the next state for MPU and CORE power domains is not lower than the
>    next state calculated by the per-device PM QoS.
>
> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

nit: this patch mixes functional changes and non-functional changes
(whitespace cleanups, alignments etc.)  For ease of review, it's best to
do non-functional cleanups as a separate patch.

Kevin
