From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 3 May 2016 18:50:21 +0800
Subject: [PATCH] clk: imx: fix ahb clock mux 1
In-Reply-To: <20160503083253.GC5874@tiger>
References: <1461877623-26838-1-git-send-email-stefan@agner.ch>
 <20160503083253.GC5874@tiger>
Message-ID: <CAA+hA=Rkfii=Mi-NuESpX8E3W37+PnCxa464yOAe5dYMgpt43g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, May 3, 2016 at 4:32 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Apr 28, 2016 at 02:07:03PM -0700, Stefan Agner wrote:
>> The clock parent of the AHB root clock when using mux option 1
>> is the SYS PLL 270MHz clock. This is specified in  Table 5-11
>> Clock Root Table of the i.MX 7Dual Applications Processor
>> Reference Manual.
>>
>> While it could be a documentation error, the 270MHz parent is
>> also mentioned in the boot ROM configuration in Table 6-28: The
>> clock is by default at 135MHz due to a POST_PODF value of 1
>> (=> divider of 2).
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>
> Anson, Frank,
>
> Can you guys confirm this change is correct?
>

I just checked the doc,
it's correct the parent should be SYS_PLL_PFD2(270Mhz).
It's a documentation error of early version and it's already fixed
in latest internal doc.

Regards
Dong Aisheng

> Shawn
>
>> ---
>> Hi Shawn,
>>
>> I did not found a clock which was based on this clock which I
>> could measure externally... But the change is backed by the
>> documentation.
>>
>> --
>> Stefan
>>
>>  drivers/clk/imx/clk-imx7d.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
>> index 7912be8..5229968 100644
>> --- a/drivers/clk/imx/clk-imx7d.c
>> +++ b/drivers/clk/imx/clk-imx7d.c
>> @@ -56,7 +56,7 @@ static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
>>       "pll_sys_pfd2_135m_clk", "pll_sys_pfd6_clk", "pll_enet_250m_clk",
>>       "pll_audio_main_clk", };
>>
>> -static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
>> +static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
>>       "pll_dram_533m_clk", "pll_sys_pfd0_392m_clk",
>>       "pll_enet_125m_clk", "pll_usb_main_clk", "pll_audio_main_clk",
>>       "pll_video_main_clk", };
>> --
>> 2.8.0
>>
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
