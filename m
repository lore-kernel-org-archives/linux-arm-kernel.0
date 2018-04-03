From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 3 Apr 2018 12:30:42 +0100
Subject: [PATCH v3 2/6] Disable instrumentation for some code
In-Reply-To: <20180402120440.31900-3-liuwenliang@huawei.com>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
 <20180402120440.31900-3-liuwenliang@huawei.com>
Message-ID: <7837103a-bcf0-6b00-14d6-bd6b80649886@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/18 13:04, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> Disable instrumentation for arch/arm/boot/compressed/*
> ,arch/arm/kvm/hyp/* and arch/arm/vdso/* because those
> code won't linkd with kernel image.
> 
> Disable kasan check in the function unwind_pop_register
> because it doesn't matter that kasan checks failed when
> unwind_pop_register read stack memory of task.
> 
> Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Just because I replied to this patch doesn't mean you can stick my
Reviewed-by tag on it. Please drop this tag until I explicitly say that
you can add it (see Documentation/process/submitting-patches.rst,
section 11).

Same goes for patch 1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
