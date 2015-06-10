From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Jun 2015 16:11:35 -0700
Subject: [PATCH v5] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <20150610225744.GT7557@n2100.arm.linux.org.uk>
References: <1428705191-15670-1-git-send-email-sboyd@codeaurora.org>
 <20150413134246.GS12732@n2100.arm.linux.org.uk>
 <557739AC.8000903@codeaurora.org>
 <20150610225744.GT7557@n2100.arm.linux.org.uk>
Message-ID: <5578C427.1070100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 03:57 PM, Russell King - ARM Linux wrote:
> diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
> index 476092b86c6e..f2c4bf437ea7 100644
> --- a/arch/arm/mach-shmobile/common.h
> +++ b/arch/arm/mach-shmobile/common.h
> @@ -13,7 +13,8 @@ extern void shmobile_smp_boot(void);
>  extern void shmobile_smp_sleep(void);
>  extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
>  			      unsigned long arg);
> -extern int shmobile_smp_cpu_disable(unsigned int cpu);
> +extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
> +extern void shmobile_invalidate_start(void);
>
> which your original patch did not include.  The tree I'm applying to
> (-rc1) contains:
>
> extern int shmobile_smp_cpu_disable(unsigned int cpu);
> extern void shmobile_invalidate_start(void);
>
> there.  Hence git quite rightfully declines to apply the patch.
>

Thanks. Fixed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
