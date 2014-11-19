From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 19 Nov 2014 16:54:10 +0530
Subject: [PATCH v4] ARM: EXYNOS: add Exynos3250 PMU support
In-Reply-To: <1908469.QaqIJlesoD@amdc1032>
References: <1908469.QaqIJlesoD@amdc1032>
Message-ID: <000a01d003eb$79fe9630$6dfbc290$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 18, 2014 11:05 PM, Bartlomiej Zolnierkiewicz Wrote:
> This patch prepares the PMU code for the future:
> - suspend/resume (S2R) support
> - cpuidle AFTR/W-AFTR modes support
> on Exynos3250.
> 
> Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: Vikas Sajjan <vikas.sajjan@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Other than one small nitpick patch looks fine to me. Tested on Exynos3250
based
Espresso board and kernel booted fine.

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

> 
> +static void exynos3250_pmu_init(void)
> +{
> +	unsigned int value;
> +
> +	/*
> +	 * To prevent form issuing new bus request form L2 memory system

typo: %s/form/from

> +	 * If core status is power down, should be set '1' to L2 power down
> +	 */

Thanks,
Pankaj Dubey

> --
> 1.8.2.3
