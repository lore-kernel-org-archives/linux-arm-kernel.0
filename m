From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 2 Jul 2015 12:59:44 +0900
Subject: [PATCH v2] arm64: cpuidle: add __init section marker to
 arm_cpuidle_init
In-Reply-To: <1435803288-1478-1-git-send-email-jszhang@marvell.com>
References: <1435803288-1478-1-git-send-email-jszhang@marvell.com>
Message-ID: <CAJKOXPceoV2jk=Go+ZoJZbP1MXx-HDLJpCFK9mrR9JLRU4x8Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-02 11:14 GMT+09:00 Jisheng Zhang <jszhang@marvell.com>:
> It is not needed after booting, this patch moves the arm_cpuidle_init()
> function to the __init section.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/include/asm/cpuidle.h | 2 +-
>  arch/arm64/kernel/cpuidle.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
> index 0f74f05..5748d3b 100644
> --- a/arch/arm64/include/asm/cpuidle.h
> +++ b/arch/arm64/include/asm/cpuidle.h
> @@ -4,7 +4,7 @@
>  #include <asm/proc-fns.h>
>
>  #ifdef CONFIG_CPU_IDLE
> -extern int arm_cpuidle_init(unsigned int cpu);
> +extern int __init arm_cpuidle_init(unsigned int cpu);

No, not here but...

>  extern int arm_cpuidle_suspend(int index);
>  #else
>  static inline int arm_cpuidle_init(unsigned int cpu)

... here so the stub for !CONFIG_CPU_IDLE would be marked as well.

Best regards,
Krzysztof
