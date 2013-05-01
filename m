From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 01 May 2013 16:36:14 -0400
Subject: [PATCH 1/3] arm_arch_timer: introduce arch_timer_stolen_ticks
In-Reply-To: <1367436460-10183-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <51817CBE.4050003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 05/01/2013 03:27 PM, Stefano Stabellini wrote:
> Introduce a function, called arch_timer_stolen_ticks, called from the
> arch_timer interrupt handler to account for stolen ticks.

[...]

> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 7ade91d..30db413 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -13,6 +13,11 @@
>  int arch_timer_of_register(void);
>  int arch_timer_sched_clock_init(void);
>  
> +/* per-platform function to calculate stolen ticks (clock cycles stolen
> + * to the vcpu by the hypervisor).

Stolen from the vcpu by the hypervisor?

Is the hypervisor adjusting the Virtual Offset Register?

[...]

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
