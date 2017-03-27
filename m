From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 27 Mar 2017 17:24:59 +0200
Subject: [PATCH v6 4/4] clk: samsung: exynos-audss: Use runtime PM
In-Reply-To: <1490182543-28550-5-git-send-email-m.szyprowski@samsung.com>
References: <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170322113556eucas1p1b3434935701aba1db7868415a9c3b4f9@eucas1p1.samsung.com>
 <1490182543-28550-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <04600f3a-300e-acb0-3c23-07659648458c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 12:35 PM, Marek Szyprowski wrote:
> @@ -141,15 +141,15 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)

> +	/*
> +	 * Enable runtime PM here, so clock core with use runtime PM for all
> +	 * registered clocks.
> +	 */

While applying I rephrased the above comment to:

/*
  * Enable runtime PM here to allow the clock core using runtime PM
  * for the registered clocks.
  */

> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);

--
Thanks,
Sylwester
