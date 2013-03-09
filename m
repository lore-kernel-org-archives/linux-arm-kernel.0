From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 9 Mar 2013 18:47:26 +0800
Subject: [PATCH V3 1/4] cpufreq: exynos: Adding cpufreq driver for
 exynos5440
In-Reply-To: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
References: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <CAKohpokJafWjXj8hYT6tgYMGSqgnFCc3MZmNFco2tTeNkOWDmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 March 2013 12:13, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> +struct exynos_dvfs_data {
> +       void __iomem *base;
> +       struct resource *mem;
> +       int irq;
> +       struct clk *cpu_clk;
> +       unsigned int cur_frequency;
> +       unsigned int latency;
> +       struct cpufreq_frequency_table *freq_table;
> +       unsigned int freq_count;
> +       struct device *dev;
> +       bool dvfs_enable;

s/enable/enabled?

> +static int exynos_cpufreq_probe(struct platform_device *pdev)

> +       dvfs_info->cpu_clk = devm_clk_get(dvfs_info->dev, "armclk");
> +       if (IS_ERR_OR_NULL(dvfs_info->cpu_clk)) {

s/IS_ERR_OR_NULL/IS_ERR

> +       if (devm_request_irq(dvfs_info->dev, dvfs_info->irq, exynos_cpufreq_irq,
> +                               IRQF_TRIGGER_NONE, CPUFREQ_NAME, dvfs_info)) {
> +               pr_err("Failed to register IRQ\n");
> +               ret = -ENODEV;

use the value returned from this function rather than creating your
own.. true for all
other calls too, unless they return NULL on error.

> +}
