From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 5 Nov 2014 09:03:05 +0100
Subject: [PATCH 3/4] PM / Domains: Improve error handling while
 adding/removing devices
In-Reply-To: <CAMuHMdWMEaC3=ibf9E8dLcG=zceU5+oE9NnKyRfAM0O36cBAjg@mail.gmail.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
 <1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdWMEaC3=ibf9E8dLcG=zceU5+oE9NnKyRfAM0O36cBAjg@mail.gmail.com>
Message-ID: <CAPDyKFoA9oUOtKPvFB1Kex5-x7wn917EBUdv=jYyUwgFth4dvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2014 08:47, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Oct 28, 2014 at 3:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1358,25 +1358,81 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
>>
>>  #endif /* CONFIG_PM_SLEEP */
>>
>> -static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *dev)
>> +static int genpd_alloc_dev_data(struct generic_pm_domain *genpd,
>> +                               struct device *dev, struct gpd_timing_data *td)
>>  {
>
> [...]
>
>> +       if (genpd->attach_dev)
>> +               genpd->attach_dev(dev);
>
> Note that dev->pm_domain is not yet set at this point, so the callee
> can no longer
> know to which domain the device is being attached.
> Should we re-add the parameter, or move the attach_dev() back to
> __pm_genpd_add_device(), like Kevin suggested.

I agree.

I am working on a new version, which adopts to your suggestions.

Kind regards
Uffe
