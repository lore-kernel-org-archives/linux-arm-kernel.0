From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:01:51 -0700
Subject: [PATCH fixes-for-current] arm64: dts: exynos: Fix interrupt type
 for I2S1 device on Exynos5433
In-Reply-To: <20180506145524.14570-1-krzk@kernel.org>
References: <20180506145524.14570-1-krzk@kernel.org>
Message-ID: <20180514080151.hykqjt5232nsb5ti@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2018 at 04:55:24PM +0200, Krzysztof Kozlowski wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> All interrupts from SoC internal modules are level triggered, so fix
> incorrect trigger type for I2S1 device on Exynos5433 SoCs.
> 
> This fixes following kernel warning:
> 
> WARNING: CPU: 2 PID: 1 at drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0xb0/0xb8
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc7-next-20180329 #646
> Hardware name: Samsung TM2 board (DT)
> pstate: 20000005 (nzCv daif -PAN -UAO)
> pc : gic_irq_domain_translate+0xb0/0xb8
> lr : irq_create_fwspec_mapping+0x64/0x328
> sp : ffff0000098b38d0
> ...
> Call trace:
>  gic_irq_domain_translate+0xb0/0xb8
>  irq_create_of_mapping+0x78/0xa0
>  of_irq_get+0x6c/0xa0
>  of_irq_to_resource+0x38/0x108
>  of_irq_to_resource_table+0x50/0x78
>  of_device_alloc+0x118/0x1b8
>  of_platform_device_create_pdata+0x54/0xe0
>  of_platform_bus_create+0x118/0x340
>  of_platform_bus_create+0x17c/0x340
>  of_platform_populate+0x74/0xd8
>  of_platform_default_populate_init+0xb0/0xcc
>  do_one_initcall+0x50/0x158
>  kernel_init_freeable+0x184/0x22c
>  kernel_init+0x10/0x108
>  ret_from_fork+0x10/0x18
> ---[ end trace 6decb2b3078d73f0 ]---
> 
> Fixes: d8d579c316e8 ("ARM: dts: exynos: Add I2S1 device node to exynos5433")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> Hi Arnd and Olof,
> 
> That's one fix for current release cycle (issue introduced in merge window).

Applied to fixes. Thanks!


-Olof
