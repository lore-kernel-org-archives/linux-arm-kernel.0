From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Tue, 18 Jun 2013 12:40:39 +0530
Subject: [PATCH v5 7/7] clk: samsung: Add EPLL and VPLL freq table for
 exynos5250 SoC
In-Reply-To: <CAL1qeaHSmMajbuChS6BLzW=jQWBF7Dse8pvSLGsZibzCUdx_hQ@mail.gmail.com>
References: <1370712862-10501-1-git-send-email-yadi.brar@samsung.com>
 <1370712862-10501-8-git-send-email-yadi.brar@samsung.com>
 <CAL1qeaHSmMajbuChS6BLzW=jQWBF7Dse8pvSLGsZibzCUdx_hQ@mail.gmail.com>
Message-ID: <CAD025yQ3MnPyVmDCCdGNsvkCPeGRLyAuf7KNgxfKc9JL08qXDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 18 June 2013 01:38, Andrew Bresticker <abrestic@chromium.org> wrote:
>> +static __initdata struct samsung_pll_rate_table epll_24mhz_tbl[] = {
>> +       /* sorted in descending order */
>> +       /* PLL_36XX_RATE(rate, m, p, s, k) */
>> +       PLL_36XX_RATE(192000000, 48, 3, 1, 0),
>> +       PLL_36XX_RATE(180633600, 45, 3, 1, 10381),
>> +       PLL_36XX_RATE(180000000, 45, 3, 1, 0),
>> +       PLL_36XX_RATE(73728000, 73, 3, 3, 47710),
>> +       PLL_36XX_RATE(67737600, 90, 4, 3, 20762),
>> +       PLL_36XX_RATE(49152000, 49, 3, 3, 9962),
>> +       PLL_36XX_RATE(45158400, 45, 3, 3, 10381),
>> +       PLL_36XX_RATE(32768000, 131, 3, 5, 4719),
>> +       { },
>> +};
>
> I believe the UM says that 64 <= m <= 511.  Although the above seems
> to work on 5250 and 5420, it might be better to use a table that
> conforms to the constraint on m:
>

OK, will test with the below table and resend.


> PLL_36XX_RATE(192000000, 64, 2, 2, 0),
> PLL_36XX_RATE(180633600, 90, 3, 2, 20762),
> PLL_36XX_RATE(180000000, 90, 3, 2, 0),
> PLL_36XX_RATE(73728000, 98, 2, 4, 19923),
> PLL_36XX_RATE(67737600, 90, 2, 4, 20762),
> PLL_36XX_RATE(49152000, 98, 3, 4, 19923),
> PLL_36XX_RATE(45158400, 90, 3, 4, 20762),
> PLL_36XX_RATE(32768000, 131, 3, 5, 4719)
>
> Thanks,
> Andrew



--
Thanks and Regards
 Vikas Sajjan
