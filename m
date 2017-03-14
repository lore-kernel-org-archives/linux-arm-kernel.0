From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 15:37:03 +0100
Subject: [PATCH v2 2/4] phy: exynos5: Remove duplicated defines of PHY
 register defines
In-Reply-To: <20170311182534.13345-3-krzk@kernel.org>
References: <20170311182534.13345-1-krzk@kernel.org>
 <20170311182534.13345-3-krzk@kernel.org>
 <CGME20170314143705epcas5p42e226d072b9ec705bb0dca981923f313@epcas5p4.samsung.com>
Message-ID: <10362020.XmlhBa7gD6@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 11, 2017 08:25:32 PM Krzysztof Kozlowski wrote:
> Phy drivers access PMU region through regmap provided by exynos-pmu
> driver.   However there is no need to duplicate defines for PMU
> registers.  Instead just use whatever is defined in exynos-regs-pmu.h.
> 
> This reduces number of defines and allows removal of one header.

exynos5-pmu.h goes away in patch #4

> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/phy/phy-exynos-dp-video.c           |  1 +
>  drivers/phy/phy-exynos5-usbdrd.c            |  1 +
>  include/linux/mfd/syscon/exynos5-pmu.h      | 27 ---------------------------
>  include/linux/soc/samsung/exynos-regs-pmu.h |  8 ++++++++
>  4 files changed, 10 insertions(+), 27 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
