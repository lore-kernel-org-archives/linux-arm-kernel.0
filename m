From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 27 Mar 2017 17:24:49 +0200
Subject: [PATCH v6 3/4] clk: samsung: exynos5433: Add runtime PM support
In-Reply-To: <1490182543-28550-4-git-send-email-m.szyprowski@samsung.com>
References: <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170322113555eucas1p2e6d19d66de5dc48b9f34e4b639759f78@eucas1p2.samsung.com>
 <1490182543-28550-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <583f5de0-ef54-2558-9673-a2b52f38e5e9@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 12:35 PM, Marek Szyprowski wrote:
> +static int __init exynos5433_cmu_probe(struct platform_device *pdev)
> +{

> +	/*
> +	 * Enable runtime pm here, so clock core with use runtime pm for all
> +	 * registered clocks. Additionally we increase the runtime PM usage
> +	 * count during the clock registration, to avoid the clock core from
> +	 * runtime suspending the device.
> +	 */

While applying I rephrased the above comment to:

/*
  * Enable runtime PM here to allow the clock core using runtime PM
  * for the registered clocks. Additionally, we increase the runtime
  * PM usage count before registering the clocks, to prevent the
  * clock core from runtime suspending the device.
  */

> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);


-- 
Thanks,
Sylwester
