From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jan 2010 10:59:00 +0000
Subject: [RFC PATCH 06/12] arm: msm: set L2CR1 to enable prefetch and
	burst on Scorpion.
In-Reply-To: <1264719577-5436-7-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-7-git-send-email-dwalker@codeaurora.org>
Message-ID: <1264762740.4242.40.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 22:59 +0000, Daniel Walker wrote:
> @@ -242,6 +243,10 @@ __v7_setup:
>         mcr     p15, 0, r4, c2, c0, 1           @ load TTB1
>         mov     r10, #0x1f                      @ domains 0, 1 = manager
>         mcr     p15, 0, r10, c3, c0, 0          @ load domain access register
> +#ifdef CONFIG_ARCH_MSM_SCORPION
> +       mov     r0, #0x77
> +       mcr     p15, 3, r0, c15, c0, 3          @ set L2CR1
> +#endif

I thought we want to move these out of the kernel into the boot loader
(or boot monitor or bios or whatever it's called).

-- 
Catalin
