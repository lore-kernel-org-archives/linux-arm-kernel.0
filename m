From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 Feb 2015 12:46:20 +0100
Subject: [PATCH] ARM: fix exynos randconfig build error
In-Reply-To: <E1YQa78-0000O0-A4@rmk-PC.arm.linux.org.uk>
References: <E1YQa78-0000O0-A4@rmk-PC.arm.linux.org.uk>
Message-ID: <CAJKOXPf2F-g9fU9TrNXz8LPwp8fBNZ6NpaAoP15N0nbHWVesaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-25 12:26 GMT+01:00 Russell King <rmk+kernel@arm.linux.org.uk>:
> The following error was observed with SMP=n in v4.0-rc1:
>
> arch/arm/mach-exynos/pm.c: In function 'exynos_cpu0_enter_aftr':
> arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of function 'arch_send_wakeup_ipi_mask' [-Werror=implicit-function-declaration]
>
> As the code unconditionally calls a function only available with SMP=y,
> make the Exynos PM support depend on SMP.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Hi,

Thanks for the patch but this already waits for Kukjin top be picked
up. The first patch was similar to yours (adds dependency on SMP),
sent on 4th of February:
https://patchwork.ozlabs.org/patch/436231/

But later Bartlomiej fixed this in other way (allowing to use cpuidle
on non-SMP):
https://patchwork.ozlabs.org/patch/436445/

Unfortunately none of them were picked up.

Best regards,
Krzysztof
