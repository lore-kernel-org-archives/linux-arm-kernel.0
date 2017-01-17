From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jan 2017 19:48:17 +0200
Subject: [PATCH v2 11/13] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
In-Reply-To: <1484657084-26227-12-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124502eucas1p131b3b424454ee380b0c93899989a51f6@eucas1p1.samsung.com>
 <1484657084-26227-12-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170117174817.ollml6z2qaopvr3u@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 01:44:42PM +0100, Marek Szyprowski wrote:
> This patch moves pad retention control from PMU driver to Exynos pin
> controller driver. This helps to avoid possible ordering and logical
> dependencies between machine, PMU and pin control code. Till now it
> worked fine only because sys_ops for PMU and pin controller were called
> in registration order.
> This is also a preparation for adding new features to Exynos pin
> controller driver, like runtime power management and suspending
> individual pin controllers, which might be a part of some power domain.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-exynos/suspend.c           |  64 --------------
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 146 +++++++++++++++++++++++++++++++
>  2 files changed, 146 insertions(+), 64 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
