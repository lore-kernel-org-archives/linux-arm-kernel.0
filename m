From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 5 May 2014 19:53:14 +0530
Subject: [PATCH 1/2] PM / OPP: Remove cpufreq wrapper dependency on
 internal data organization
In-Reply-To: <1399296830-13056-2-git-send-email-nm@ti.com>
References: <1399296830-13056-1-git-send-email-nm@ti.com>
 <1399296830-13056-2-git-send-email-nm@ti.com>
Message-ID: <CAKohpomeP3Ftx8mH=x0Hj7HEpw6A9X8O8JEFqvrJbkZYDqDS6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2014 19:03, Nishanth Menon <nm@ti.com> wrote:
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>  int dev_pm_opp_init_cpufreq_table(struct device *dev,
>                             struct cpufreq_frequency_table **table)
>  {
> -       struct device_opp *dev_opp;
>         struct dev_pm_opp *opp;
> -       struct cpufreq_frequency_table *freq_table;
> -       int i = 0;
> +       struct cpufreq_frequency_table *freq_table = NULL;
> +       int i, max_opps, ret = 0;
> +       unsigned long rate;
>
> -       /* Pretend as if I am an updater */
> -       mutex_lock(&dev_opp_list_lock);

What if opp is being added for some reason at the same time?
I hope we can surely see some awkward results, maybe some
NULL pointers invocations as well..
