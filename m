From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 15:06:23 +0100
Subject: [PATCH 2/3] soc: samsung: Do not build ARMv7 PMU drivers on ARMv8
In-Reply-To: <20170311213856.21701-3-krzk@kernel.org>
References: <20170311213856.21701-1-krzk@kernel.org>
 <20170311213856.21701-3-krzk@kernel.org>
 <CGME20170314140626epcas5p20694a5324299c556fbaf7df1e9bf5955@epcas5p2.samsung.com>
Message-ID: <10434341.iCgJC0vsO4@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 11, 2017 11:38:55 PM Krzysztof Kozlowski wrote:
> The Exynos Power Management Unit (PMU) drivers contain quite large
> static arrays of register values necessary for given Exynos SoC to enter
> low power mode.  All this data is useless for ARMv8 SoC like
> Exynos5433, because the image will not be shared between ARMv7 and
> ARMv8.
> 
> Add additional Kconfig symbol for selecting the SoC-specific driver
> addons thus skipping the useless data in the final image (this is
> similar approach to chosen for Exynos clock controller drivers):
>  - exynos-pmu driver will be compiled on both architectures ARMv7
>    and ARMv8,
>  - additional driver_data for ARMv7 SoCs will not be built on ARMv8
>    and a macro will return NULL for them in of_device_id - this should
>    be safe as these compatibles cannot match on ARMv7 and driver
>    anyway handles NULL driver_data,
>  - on ARMv8 compile only exynos-pmu driver which exposes the
>    syscon-regmap for PMU address space.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
