From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jan 2017 19:54:27 +0200
Subject: [PATCH v2 12/13] pinctrl: samsung: Move retention control from
 mach-s5pv210 to the pinctrl driver
In-Reply-To: <1484657084-26227-13-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124502eucas1p19ce0cd772fc4295b207b20cdad30485e@eucas1p1.samsung.com>
 <1484657084-26227-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170117175427.4jgjkhwd6etti7qj@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 01:44:43PM +0100, Marek Szyprowski wrote:
> This patch moves pad retention control from S5PV210 machine code to
> Exynos pin controller driver. This helps to avoid possible ordering
> and logical dependencies between machine and pin control code. Till
> now it worked fine only because sys_ops for machine code and pin
> controller were called in registration order.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-s5pv210/pm.c               |  7 ----
>  arch/arm/mach-s5pv210/regs-clock.h       |  4 ---

For mach-s5pv210:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
