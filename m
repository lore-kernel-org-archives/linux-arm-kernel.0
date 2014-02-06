From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 06 Feb 2014 11:39:13 +0000
Subject: [PATCH 3/6] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <1391686253-13436-3-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-3-git-send-email-will.deacon@arm.com>
Message-ID: <52F37461.8020504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/14 11:30, Will Deacon wrote:
> When sending an SGI to another CPU, we require a DSB to ensure that
> any pending stores to normal memory are made visible to the recipient
> before the interrupt arrives.
> 
> Rather than use a dsb() (which will soon cause an assembly error on
> arm64) followed by a writel_relaxed, we can use a writel instead, which
> will emit a dsb st prior to the str.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Looks sensible to me.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
