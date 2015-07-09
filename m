From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Jul 2015 10:42:30 +0100
Subject: [PATCH 01/13] arm/arm64: Add new is_kernel_in_hyp_mode predicate
In-Reply-To: <1436372356-30410-2-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150709094230.GA20105@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +static inline bool is_kernel_in_hyp_mode(void)
> +{
> +	u64 el;
> +
> +	asm("mrs %0, CurrentEL" : "=r" (el));
> +	return el == CurrentEL_EL2;
> +}

If you can include cputype.h, I think this can be:

static inline bool is_kernel_in_hyp_mode(void)
{
	return read_cpuid(CurrentEL) == CurrentEL_EL2;
}

Mark.
