From: amit.kachhap@gmail.com (amit kachhap)
Date: Mon, 11 Mar 2013 09:15:50 +0530
Subject: [PATCH V3 1/4] cpufreq: exynos: Adding cpufreq driver for
 exynos5440
In-Reply-To: <CAKohpokJafWjXj8hYT6tgYMGSqgnFCc3MZmNFco2tTeNkOWDmQ@mail.gmail.com>
References: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
 <CAKohpokJafWjXj8hYT6tgYMGSqgnFCc3MZmNFco2tTeNkOWDmQ@mail.gmail.com>
Message-ID: <CADGdYn5hQUmYM5K=-tdsfACXKsJSb=AB+n3N8ATtzD=mFJikMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Sat, Mar 9, 2013 at 4:17 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 7 March 2013 12:13, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
>> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
>> +struct exynos_dvfs_data {
>> +       void __iomem *base;
>> +       struct resource *mem;
>> +       int irq;
>> +       struct clk *cpu_clk;
>> +       unsigned int cur_frequency;
>> +       unsigned int latency;
>> +       struct cpufreq_frequency_table *freq_table;
>> +       unsigned int freq_count;
>> +       struct device *dev;
>> +       bool dvfs_enable;
>
> s/enable/enabled?
Ok
>
>> +static int exynos_cpufreq_probe(struct platform_device *pdev)
>
>> +       dvfs_info->cpu_clk = devm_clk_get(dvfs_info->dev, "armclk");
>> +       if (IS_ERR_OR_NULL(dvfs_info->cpu_clk)) {
>
> s/IS_ERR_OR_NULL/IS_ERR
Ok.
>
>> +       if (devm_request_irq(dvfs_info->dev, dvfs_info->irq, exynos_cpufreq_irq,
>> +                               IRQF_TRIGGER_NONE, CPUFREQ_NAME, dvfs_info)) {
>> +               pr_err("Failed to register IRQ\n");
>> +               ret = -ENODEV;
>
> use the value returned from this function rather than creating your
> own.. true for all
> other calls too, unless they return NULL on error.
>
Will integrate your suggestions in the next version.

Thanks,
Amit D
>> +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
