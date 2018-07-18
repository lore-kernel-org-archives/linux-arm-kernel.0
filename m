From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jul 2018 08:17:50 +0200
Subject: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos
 platform
In-Reply-To: <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
 <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
Message-ID: <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2018 at 22:23, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof
>
> On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Hi Anand,
>>
>> Thanks for patch.
>>
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> clk_summary do not show tmu_apbif clk enable, so replace
>>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>>
>> This is not valid reason to do a change. What is clk_summary does not
>> really matter. Your change has negative impact on power consumption as
>> the clock stays enabled all the time. This is not what we want... so
>> please explain it more - why you need the clock to be enabled all the
>> time? What is broken (clk_summary is not broken in this case)?
>>
>
> Opps I could not explain some more in my commit message.
>
> Actually TMU sensor for Exynos process are controlled by so external clk
>
> Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
> Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
> control the CLK_SENSE tmu.
>
> So as per my understanding tmu is clk driver which control the flow  PMIC.
>
> clk_prepare_enable combine clk_prepare and clk_enable
> and clk_disable_unprepare combine clk_disable and clk_unprepare.
>
> most of the driver prefer clk_prepare_enable and clk_disable_unprepare.
>
> clk_summary is just a reference looking point where we could check the
> clk is enable/disable.
>
> what is broken ?
> I still few more parameter need to tuned to configure the tmu driver.

I am sorry but I am still unable to see what is broken and what are
you trying to fix. I asked what is broken and you replied that there
is a sensor, there is a clock, drivers use clk_prepare_enable and some
more parameter need to be tuned... None of these are answers to
question - what is broken. How can I reproduce the problem?

Best regards,
Krzysztof
