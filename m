From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 17 Oct 2013 10:29:45 +0530
Subject: [PATCH] cpufreq: exynos: Convert exynos-cpufreq to platform driver
In-Reply-To: <1381939238-30398-1-git-send-email-t.figa@samsung.com>
References: <1381939238-30398-1-git-send-email-t.figa@samsung.com>
Message-ID: <CAK9yfHwW+ofX5f8hHF=MYQn=CUMyiHvg4iAH-cHFW7JQ5Qnscw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz, Lukasz,

On 16 October 2013 21:30, Tomasz Figa <t.figa@samsung.com> wrote:
> From: Lukasz Majewski <l.majewski@samsung.com>
>
> +static struct platform_driver exynos_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "exynos-cpufreq",
> +               .owner  = THIS_MODULE,
> +       },
> +       .probe = exynos_cpufreq_init,

I think the prototype of this function should be changed to:
static int __init exynos_cpufreq_init(struct platform_device *pdev)

to avoid compilation warnings.

-- 
With warm regards,
Sachin
