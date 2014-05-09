From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 16:57:26 +0100
Subject: [PATCH] arm64: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <1399322907-21280-1-git-send-email-larry.bassel@linaro.org>
References: <1399322907-21280-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <20140509155726.GK7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 09:48:27PM +0100, Larry Bassel wrote:
> Support for arch_irq_work_raise() was missing from
> arm64 (a prerequisite for FULL_NOHZ).
> 
> This patch is based on the arm32 patch ARM 7872/1
> which ports cleanly.
[...]
> +#ifdef CONFIG_IRQ_WORK
> +void arch_irq_work_raise(void)
> +{
> +	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> +}
> +#endif

There was a subsequent patch adding is_smp() check here (c682e51dbc98
ARM: 7887/1: Don't smp_cross_call() on UP devices in
arch_irq_work_raise()). Don't we need it?

-- 
Catalin
