From: r.sh.open@gmail.com (Rahul Sharma)
Date: Mon, 23 Dec 2013 10:09:17 +0530
Subject: [PATCH 1/7] ARM: EXYNOS: initial board support for exynos5260 SoC
In-Reply-To: <CAK9yfHzX1+Rp3DCZiJSjE7VO6+TaDW7iqUZVpgRNkjVJofWauA@mail.gmail.com>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-2-git-send-email-rahul.sharma@samsung.com>
 <CAK9yfHzX1+Rp3DCZiJSjE7VO6+TaDW7iqUZVpgRNkjVJofWauA@mail.gmail.com>
Message-ID: <CAPdUM4PfrVyz+TpEPt-0xnhrjNwp_qbk_PkBtZGu15pfNSMqkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Sachin,

On 9 December 2013 11:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Rahul,
>
> On 6 December 2013 21:26, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>>
>> This patch add basic arch side support for exynos5260 SoC.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>
> Since you are posting the patch, your signed off is also required.

Right. I will add my Sign off.

>
> [snip]
>
>>  void exynos4_restart(enum reboot_mode mode, const char *cmd)
>>  {
>>         __raw_writel(0x1, S5P_SWRESET);
>> @@ -371,7 +387,8 @@ static void __init exynos4_map_io(void)
>>  static void __init exynos5_map_io(void)
>>  {
>>         iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
>> -
>> +       if (soc_is_exynos5260())
>> +               iotable_init(exynos5260_iodesc, ARRAY_SIZE(exynos5260_iodesc));
>
> Add this after 5250 to maintain numerical order.

ok.
>
>>         if (soc_is_exynos5250())
>>                 iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
>>  }
>
> [snip]
>>
>>  #define S5P_VA_SYSRAM          S3C_ADDR(0x02400000)
>>  #define S5P_VA_SYSRAM_NS       S3C_ADDR(0x02410000)
>> +
> Unnecessary blank line addition.

I will remove this.

Regards,
Rahul Sharma.

>
>
> --
> With warm regards,
> Sachin
