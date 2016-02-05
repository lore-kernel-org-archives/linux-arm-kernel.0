From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 05 Feb 2016 15:06:20 +0200
Subject: [PATCH V2 6/6] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <1454487337-30184-7-git-send-email-zhang.chunyan@linaro.org>
References: <1454487337-30184-1-git-send-email-zhang.chunyan@linaro.org>
 <1454487337-30184-7-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <87h9hn5msz.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> +#ifndef CONFIG_64BIT
> +static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> +{
> +	asm volatile("strd %1, %0"
> +		     : "+Qo" (*(volatile u64 __force *)addr)
> +		     : "r" (val));
> +}

Is it really ok to do this for all !64bit arms, inside a driver, just
like that? I'm not an expert, but I'm pretty sure there's more to it.

Regards,
--
Alex
