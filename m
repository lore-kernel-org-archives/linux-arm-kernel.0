From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 26 Sep 2013 14:28:12 +0530
Subject: [PATCH] clk: samsung: fix cpll clock register offsets for
 exynos5420 SoC
In-Reply-To: <02c601ceba75$24c763b0$6e562b10$@org>
References: <1380099864-32031-1-git-send-email-chander.kashyap@linaro.org>
 <02c601ceba75$24c763b0$6e562b10$@org>
Message-ID: <CANuQgHHrPaEM0RJRivAarSU5y1V1F40YYtuPO8LA1FNAM6LEPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 September 2013 10:29, Kukjin Kim <kgene@kernel.org> wrote:
> Chander Kashyap wrote:
>>
>> Fixes cpll control and lock register offset values for Exynos5420 SoC.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>
> Just nit in the subject,
> 'clk: exynos5420: ...' or 'clk/exynos5420: ...' would be nice...
>

Thanks for review.
I will re-post it.

> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>
> Thanks,
> Kukjin
>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c
>> b/drivers/clk/samsung/clk-exynos5420.c
>> index 86dfc64..892aac0 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -730,8 +730,8 @@ struct samsung_gate_clock exynos5420_gate_clks[]
>> __initdata = {
>>  struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
>>       [apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
>>               APLL_CON0, NULL),
>> -     [cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
>> -             MPLL_CON0, NULL),
>> +     [cpll] = PLL(pll_2550, fout_cpll, "fout_cpll", "fin_pll", CPLL_LOCK,
>> +             CPLL_CON0, NULL),
>>       [dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", DPLL_LOCK,
>>               DPLL_CON0, NULL),
>>       [epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
>> --
>> 1.7.9.5
>



-- 
with warm regards,
Chander Kashyap
