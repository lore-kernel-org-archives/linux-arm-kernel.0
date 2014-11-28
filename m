From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 28 Nov 2014 08:26:28 +0100
Subject: [PATCH V2 1/3] PM / Domains: Initial PM clock support for genpd
In-Reply-To: <3169286.RI9fuSo8ZA@vostro.rjw.lan>
References: <1417099911-12688-1-git-send-email-ulf.hansson@linaro.org>
 <1417099911-12688-2-git-send-email-ulf.hansson@linaro.org>
 <3169286.RI9fuSo8ZA@vostro.rjw.lan>
Message-ID: <CAPDyKFp8sSCAt-oZTex-UG1RAFUYQBRPwbKuGmYiGP+0OtaTYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> If you defined the flag as
>
>         #define PM_DOMAIN_FLAGS_PM_CLK  (1U << 0)
>
> (which is a kind of usual way to do that), you wouldn't need the
> bitops.h above.
>
> Moreover, I personally don't like #defines in struct definitions.
>
>>
>> @@ -76,6 +77,8 @@ struct generic_pm_domain {
>>                         struct device *dev);
>>       void (*detach_dev)(struct generic_pm_domain *domain,
>>                          struct device *dev);
>> +     unsigned int flags;             /* Bit field of configs for genpd */
>> +#define PM_DOMAIN_PM_CLK     BIT(0)  /* PM domain uses PM clk */

While I fix your above comments, I wonder whether I actually also
should change the prefix of the define as well.
>From "PM_DOMAIN" to "GENPD". Cause I think it's a genpd specific
define and not a "PM domain" define. Please tell me if you have any
objections to that.

>>  };
>>
>>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.


Thanks for review!

Kind regards
Uffe
