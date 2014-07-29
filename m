From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue, 29 Jul 2014 17:16:49 +0530
Subject: [PATCH v8 2/6] clk: samsung: add cpu clock configuration data and
 instantiate cpu clock
In-Reply-To: <53D773DA.6050003@gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
 <1406611711-25112-3-git-send-email-thomas.ab@samsung.com>
 <53D773DA.6050003@gmail.com>
Message-ID: <CAJuA9ahuch8c9CzVwO7pf8Chf0G3coNH4KLOF29Sj7dQ9gqO_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Tue, Jul 29, 2014 at 3:43 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Thomas,
>
> Just few minor comments for things I probably missed before.
>
> On 29.07.2014 07:28, Thomas Abraham wrote:
>
> [snip]
>
>> @@ -1356,6 +1357,16 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
>>                       VPLL_LOCK, VPLL_CON0, NULL),
>>  };
>>
>> +static const struct exynos_cpuclk_cfg_data e4210_armclk_d[] __initconst = {
>> +     { 1200000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 5), },
>> +     { 1000000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 4), },
>> +     {  800000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>> +     {  500000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>> +     {  400000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
>
> I have noticed that the old driver does not have this operating point.
> While it is probably OK to add this one and even few more for all
> possible APLL settings, I am interested in how you obtained the values
> for DIV0 and DIV1 registers for this configuration.

I found these values from an old internal repo. So far no trouble seen
with these values in all the testing.

>
>> +     {  200000, E4210_CPU_DIV0(0, 1, 1, 1, 3, 1), E4210_CPU_DIV1(0, 3), },
>> +     {  0 },
>> +};
>
> [snip]
>
>> diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
>> index 4273891..855d809 100644
>> --- a/include/dt-bindings/clock/exynos5250.h
>> +++ b/include/dt-bindings/clock/exynos5250.h
>> @@ -21,6 +21,7 @@
>>  #define CLK_FOUT_CPLL                6
>>  #define CLK_FOUT_EPLL                7
>>  #define CLK_FOUT_VPLL                8
>> +#define CLK_ARM_CLK          12
>
> Why 12 not 9?

Exynos4 uses 12 and so just wanted to keep it same for Exynos5250 as well.

Thanks,
Thomas.

>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
