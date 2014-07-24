From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 24 Jul 2014 05:43:40 +0530
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <53D00A47.7050203@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
 <53CFA33F.6030307@nvidia.com>
 <CAKohponLh66Ubr6=wY2OZCCrK11KZDj=DmXXqXsGGTHSG45wpA@mail.gmail.com>
 <53D00A47.7050203@nvidia.com>
Message-ID: <CAKohponsS8WJy4qBa=3em9AcxfpfLZR_mx4Ln8N3Q_gBaf52NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2014 00:47, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> It's this:
>
> +static int tegra124_cpufreq_probe(struct platform_device *pdev)
> +{
> [...]
> +
> +       dfll_clk = of_clk_get_by_name(cpu_dev->of_node, "dfll");
> +       if (IS_ERR(dfll_clk)) {
> +               ret = PTR_ERR(dfll_clk);
> +               goto out_put_cpu_clk;
> +       }

This would search for clocks passed via DT, right? Why would we
get EPROBE_DEFER for that? Sorry for the stupid question.

--
viresh
