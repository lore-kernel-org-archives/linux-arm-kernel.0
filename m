From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 Aug 2016 13:33:09 +0100
Subject: [RFC PATCH v3 1/7] irqchip: gic-v3: Reset BPR during
 initialization
In-Reply-To: <1471623195-7829-2-git-send-email-daniel.thompson@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
 <1471623195-7829-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <57BAF105.1080604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/16 17:13, Daniel Thompson wrote:
> Currently, when running on FVP, CPU 0 boots up with its BPR changed from
> the reset value. This renders it impossible to (preemptively) prioritize
> interrupts on CPU 0.
> 
> This is harmless on normal systems since Linux typically does not
> support preemptive interrupts. It does however cause problems in
> systems with additional changes (such as patches for NMI simulation).
> 
> Many thanks to Andrew Thoelke for suggesting the BPR as having the
> potential to harm preemption.
> 
> Suggested-by: Andrew Thoelke <andrew.thoelke@arm.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
