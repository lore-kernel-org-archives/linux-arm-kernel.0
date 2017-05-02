From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 2 May 2017 15:17:00 +0100
Subject: [PATCH] arm: pmu: Get PMU working when the A53 is run in 32 bit
 mode
In-Reply-To: <1493733691-43814-1-git-send-email-alcooperx@gmail.com>
References: <1493733691-43814-1-git-send-email-alcooperx@gmail.com>
Message-ID: <0f716b0c-b9ac-29d9-2909-50906ad90bd3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On 02/05/17 15:01, Al Cooper wrote:
> From: Al Cooper <al.cooper@broadcom.com>
> 
> When the A53 is run in A15 (32 bit) mode, the registers used to
> access the counters are A15 style registers, but the actual
> counters are the A53 counters not A15 counters. This patch will
> select a PMU counters map for the A53 if the device tree pmu
> "compatible" property includes "arm,cortex-a53-pmu".

I wasn't aware of an "A15 mode"! Is there an ARM3 mode, while we're at
it? ;-)

More seriously, you seem to take the problem from the wrong end. If you
have an ARMv8 core, you should use the PMUv3 driver (because that is
what your A53 has), and not the ARMv7 PMU.

To that affect, I've posted this[1] a while ago. Can you please give it
a go?

Thanks,

	M.

[1]: https://www.spinics.net/lists/arm-kernel/msg571476.html
-- 
Jazz is not dead. It just smells funny...
