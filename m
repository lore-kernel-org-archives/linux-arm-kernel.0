From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 2 May 2014 11:24:45 +0200
Subject: [PATCH 1/5] pm: domains: quieten down generic pm domains
In-Reply-To: <10021780.rnCkCYmgZH@vostro.rjw.lan>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <E1WeP8U-0000Ug-RQ@rmk-PC.arm.linux.org.uk>
 <10021780.rnCkCYmgZH@vostro.rjw.lan>
Message-ID: <CAPDyKFpKnhcttY-BWDEG=XTYsKHro0t5G7YBao-+F=o3ez3grA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 May 2014 01:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Sunday, April 27, 2014 02:28:50 PM Russell King wrote:
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
>
> Since you need this one and [2/5] for the rest of the patchset, please feel
> free to take them through your tree if that's convenient.

Unless it complicates things for Russell, I would prefer if this could
go via Rafael's tree.

I have a quite big patchset for the PM domain, it would help me if I
have a single point to base my work upon.

Additionally, you have Tomasz Figa patchset below to consider for the
PM domain code.

[PATCH v3 0/3] Generic Device Tree based power domain look-up

Kind regards
Ulf Hansson

>
>> ---
>>  drivers/base/power/domain.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index bfb8955c406c..ea91ea0e137b 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -42,7 +42,7 @@
>>       struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;                  \
>>       if (!__retval && __elapsed > __td->field) {                             \
>>               __td->field = __elapsed;                                        \
>> -             dev_warn(dev, name " latency exceeded, new value %lld ns\n",    \
>> +             dev_dbg(dev, name " latency exceeded, new value %lld ns\n",     \
>>                       __elapsed);                                             \
>>               genpd->max_off_time_changed = true;                             \
>>               __td->constraint_changed = true;                                \
>> @@ -242,7 +242,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>>                       genpd->max_off_time_changed = true;
>>                       genpd_recalc_cpu_exit_latency(genpd);
>>                       if (genpd->name)
>> -                             pr_warning("%s: Power-on latency exceeded, "
>> +                             pr_debug("%s: Power-on latency exceeded, "
>>                                       "new value %lld ns\n", genpd->name,
>>                                       elapsed_ns);
>>               }
>> @@ -566,7 +566,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>>                       genpd->power_off_latency_ns = elapsed_ns;
>>                       genpd->max_off_time_changed = true;
>>                       if (genpd->name)
>> -                             pr_warning("%s: Power-off latency exceeded, "
>> +                             pr_debug("%s: Power-off latency exceeded, "
>>                                       "new value %lld ns\n", genpd->name,
>>                                       elapsed_ns);
>>               }
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
