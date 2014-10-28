From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 28 Oct 2014 12:48:48 +0530
Subject: [PATCH v2 3/7] clk: samsung: exynos7: add clocks for RTC block
In-Reply-To: <544E736D.1070001@samsung.com>
References: <1413870237-1821-1-git-send-email-a.kesavan@samsung.com>
 <1413870237-1821-4-git-send-email-a.kesavan@samsung.com>
 <544E736D.1070001@samsung.com>
Message-ID: <CAM4voamtQfY2gvtKt3_yg4eVshxswtEaCbp8+n-jWDc3xx2TLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sylwester,

On Mon, Oct 27, 2014 at 10:01 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi,
>
> On 21/10/14 07:43, Abhilash Kesavan wrote:
>> From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
>>
>> Add clock support for the RTC block in Exynos7.
>>
>> Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  .../devicetree/bindings/clock/exynos7-clock.txt    |    5 ++
>>  drivers/clk/samsung/clk-exynos7.c                  |   54 ++++++++++++++++++++
>>  include/dt-bindings/clock/exynos7-clk.h            |   17 +++---
>>  3 files changed, 70 insertions(+), 6 deletions(-)
> [...]
>> diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
>> index ff63c4e..3227679 100644
>> --- a/include/dt-bindings/clock/exynos7-clk.h
>> +++ b/include/dt-bindings/clock/exynos7-clk.h
>> @@ -11,12 +11,13 @@
>>  #define _DT_BINDINGS_CLOCK_EXYNOS7_H
>>
>>  /* TOPC */
>> -#define DOUT_ACLK_PERIS                      1
>> -#define DOUT_SCLK_BUS0_PLL           2
>> -#define DOUT_SCLK_BUS1_PLL           3
>> -#define DOUT_SCLK_CC_PLL             4
>> -#define DOUT_SCLK_MFC_PLL            5
>> -#define TOPC_NR_CLK                  6
>> +#define DOUT_ACLK_CCORE_133          1
>> +#define DOUT_ACLK_PERIS                      2
>> +#define DOUT_SCLK_BUS0_PLL           3
>> +#define DOUT_SCLK_BUS1_PLL           4
>> +#define DOUT_SCLK_CC_PLL             5
>> +#define DOUT_SCLK_MFC_PLL            6
>> +#define TOPC_NR_CLK                  7
>
> Please don't do that, don't change the meaning of already defined
> clock identifiers. We should carefully assign the clock identifiers
> based on the SoC documentation beforehand, not at will when we see
> fit for development of the Linux driver. Please either add
> DOUT_ACLK_CCORE_133 at the end of list or move this change to the
> first patch in your series adding initial support for Exynos7 SoC.

Thanks for reviewing this series and picking up the initial patchset.
I will re-post this patchset with the ccore clock at the end of the
list. All the future clock id entries will be added at the bottom of
the list.

Regards,
Abhilash
>
> --
> Thanks,
> Sylwester
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
