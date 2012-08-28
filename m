From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 28 Aug 2012 10:29:17 +0530
Subject: [PATCH v3 1/3] ARM: Samsung: Add support for MSHC controller
 clocks
In-Reply-To: <503BFF8E.80503@samsung.com>
References: <1345982371-26483-1-git-send-email-thomas.abraham@linaro.org>
 <1345982371-26483-2-git-send-email-thomas.abraham@linaro.org>
 <503BFF8E.80503@samsung.com>
Message-ID: <CAJuYYwT6L+Nfd_k2f9hCyJTbrqzedgOUcr7F2MbPvmstin=y4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2012 04:45, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 08/26/12 04:59, Thomas Abraham wrote:
>>
>> Add clock instances for bus interface unit clock and card interface unit
>> clock of the all four MSHC controller instances.
>>
>> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
>> ---
>>   arch/arm/mach-exynos/clock-exynos5.c |   45
>> ++++++++++++----------------------
>>   1 files changed, 16 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/clock-exynos5.c
>> b/arch/arm/mach-exynos/clock-exynos5.c
>> index 3b00e29..16d8bef 100644
>> --- a/arch/arm/mach-exynos/clock-exynos5.c
>> +++ b/arch/arm/mach-exynos/clock-exynos5.c
>> @@ -564,35 +564,30 @@ static struct clk exynos5_init_clocks_off[] = {
>>                 .enable         = exynos5_clk_ip_peris_ctrl,
>>                 .ctrlbit        = (1<<  19),
>>         }, {
>> -               .name           = "hsmmc",
>> -               .devname        = "exynos4-sdhci.0",
>> +               .name           = "biu",
>
>
> I have no idea why we change the clock name to 'biu' (bus interface unit).
> Just let me know.

The dw-mmc controller requires two clocks - bus interface unit and
card interface unit clock. Since this controller driver can be used on
platforms other than exynos, the name of the clock has to be generic.
Hence the name of the clocks used are "biu" and "ciu" as the per the
dw-mmc data sheet.

>
> [...]
>
>
>>   static struct clksrc_clk exynos5_clk_sclk_mmc0 = {
>>         .clk    = {
>> -               .name           = "sclk_mmc",
>> -               .devname        = "exynos4-sdhci.0",
>> +               .name           = "ciu",
>
>
> Same as above.

Thanks,
Thomas.
