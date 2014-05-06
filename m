From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 6 May 2014 19:52:47 +0200
Subject: [PATCH v3 1/3] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <CAPDyKFpvtRpgg-Ohv2Yi--_5mnp3ghpj7_4xyM7SjJvYCFzS6Q@mail.gmail.com>
References: <1398271618-28932-1-git-send-email-t.figa@samsung.com>
 <1398271618-28932-2-git-send-email-t.figa@samsung.com>
 <CAPDyKFpvtRpgg-Ohv2Yi--_5mnp3ghpj7_4xyM7SjJvYCFzS6Q@mail.gmail.com>
Message-ID: <CAPDyKFqtW1pV3xv1E8fhtPS99eVezGJqKq_JM4Mrq2ewJyTpog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2014 11:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 April 2014 18:46, Tomasz Figa <t.figa@samsung.com> wrote:
>> This patch introduces generic code to perform power domain look-up using
>> device tree and automatically bind devices to their power domains.
>> Generic device tree binding is introduced to specify power domains of
>> devices in their device tree nodes.
>>
>> Backwards compatibility with legacy Samsung-specific power domain
>> bindings is provided, but for now the new code is not compiled when
>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
>> will change as soon as Exynos power domain code gets converted to use
>> the generic framework in further patch.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Reviewed-by: Mark Brown <broonie@linaro.org>
>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
>> [on i.MX6 GK802]
>> Tested-by: Philipp Zabel <philipp.zabel@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

I also implemented some test-support for genpd for a ux500 SOC as well
- tested passed successfully. :-)

[snip]

>> +
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>
> I remember we discussed this earlier, but I don't think we should add
> another Kconfig for this. CONFIG_OF should be enough.
>
> I realize that we need to handle "Samsung-specific bindings", to not
> break the Exynos pm domain. Maybe adding the parsing of them into the
> generic power domain in the same patch as when we switch Exynos to the
> new API would do the trick?

I realized that there already exists CONFIG_PM_GENERIC_DOMAINS_SLEEP
and CONFIG_PM_GENERIC_DOMAINS_RUNTIME, which serves similar purpose as
CONFIG_PM_GENERIC_DOMAINS_OF would.

So, let's ignore my previous comment and move on.

Kind regards
Ulf Hansson
