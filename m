From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 17 Feb 2016 16:38:30 -0700
Subject: [RFC v2 03/12] PM / cpu_domains: Setup PM domains for
 CPUs/clusters
In-Reply-To: <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160217233830.GA1313@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12 2016 at 13:51 -0700, Lina Iyer wrote:

>+static int cpu_pd_power_on(struct generic_pm_domain *genpd)
>+{
>+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>+
>+	return pd->ops.power_on();

Needs a check for NULL ops.power_on() here.
>+}
>+
>+static int cpu_pd_power_off(struct generic_pm_domain *genpd)
>+{
>+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>+
>+	return pd->ops.power_off(genpd->state_idx,
>+			genpd->states[genpd->state_idx].param);
Needs a check for NULL ops.power_off().

Thanks,
Lina
