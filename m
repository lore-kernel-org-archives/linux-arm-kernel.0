From: dianders@chromium.org (Doug Anderson)
Date: Fri, 30 May 2014 09:29:03 -0700
Subject: [PATCH] clk: exynos5420: Keep aclk66_peric enabled during boot
In-Reply-To: <53888EF5.5090800@collabora.co.uk>
References: <1401398496-4624-1-git-send-email-dianders@chromium.org>
 <53888EF5.5090800@collabora.co.uk>
Message-ID: <CAD=FV=XREX4HkLtBLoie++w1FMMN+BOtB=1EOC3My66zOPizjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Fri, May 30, 2014 at 7:00 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
>> @@ -1239,3 +1251,15 @@ static void __init exynos5800_clk_init(struct device_node *np)
>>       exynos5x_clk_init(np, EXYNOS5800);
>>  }
>>  CLK_OF_DECLARE(exynos5800_clk, "samsung,exynos5800-clock", exynos5800_clk_init);
>> +
>> +static int __init exynos5420_clk_late_init(void)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(boot_clocks); i++) {
>> +             struct clk *to_disable = __clk_lookup(boot_clocks[i]);
>> +
>> +             clk_disable_unprepare(to_disable);
>> +     }
>> +}
>> +late_initcall(exynos5420_clk_late_init);
>>
>
> You should return 0 here.

Duh.  Done.
