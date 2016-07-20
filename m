From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Jul 2016 16:49:56 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <1467995754-32508-5-git-send-email-dave.long@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
Message-ID: <20160720154956.GE25890@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 12:35:48PM -0400, David Long wrote:
> +#define MIN_STACK_SIZE(addr)	(on_irq_stack(addr, raw_smp_processor_id()) ? \
> +	min((unsigned long)IRQ_STACK_SIZE,	\
> +	IRQ_STACK_PTR(raw_smp_processor_id()) - (addr)) : \
> +	min((unsigned long)MAX_STACK_SIZE,	\
> +	(unsigned long)current_thread_info() + THREAD_START_SP - (addr)))

I presume you've never tested the on_irq_stack() path in this macro.

-- 
Catalin
