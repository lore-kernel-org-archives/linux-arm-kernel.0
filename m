From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Apr 2010 17:05:40 +0100
Subject: [PATCH 0/6] ARM: pmu: provide a registration mechanism for IRQs
	[v3]
In-Reply-To: <000501cae7b5$97a76fb0$c6f64f10$@deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
	<20100428213619.GA16525@n2100.arm.linux.org.uk>
	<000501cae7b5$97a76fb0$c6f64f10$@deacon@arm.com>
Message-ID: <20100429160540.GE4877@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 05:04:04PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> > Please can we have an ordered set which doesn't break compilation.
> > What I think should happen is the first patch should introduce the
> > new definitions required for the platform data, and the rest of the
> > first patch should come at the very end.
> 
> Sorry about this. I've split up the first patch so that the first
> half is now:
> 
> 
> ARM: pmu: add enum describing PMU types
>     
> This patch adds an enum describing the potential PMU device types in
> preparation for PMU device registration via platform devices.
> 
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index 2829b9f..44bec1f 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -12,6 +12,11 @@
>  #ifndef __ARM_PMU_H__
>  #define __ARM_PMU_H__
>  
> +enum arm_pmu_type {
> +       ARM_PMU_DEVICE_CPU      = 0,
> +       ARM_NUM_PMU_DEVICES,
> +};
> +
>  #ifdef CONFIG_CPU_HAS_PMU
>  
>  struct pmu_irqs {
> 
> 
> which gets rid of the compilation failures. I can either supersede
> the existing patch with two more or resubmit the whole series. Which
> would you prefer?

Can you just deal with the single patch to be superseded; the rest are
fine.
