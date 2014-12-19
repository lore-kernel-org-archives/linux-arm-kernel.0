From: Ying.Liu@freescale.com (Liu Ying)
Date: Fri, 19 Dec 2014 10:23:41 +0800
Subject: [PATCH RFC v2 05/14] ARM: imx6q: clk: Add the video_27m clock
In-Reply-To: <1418898675.4212.10.camel@pengutronix.de>
References: <1418886696-11636-1-git-send-email-Ying.Liu@freescale.com>
 <1418886696-11636-6-git-send-email-Ying.Liu@freescale.com>
 <1418898675.4212.10.camel@pengutronix.de>
Message-ID: <54938C2D.1020504@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 12/18/2014 06:31 PM, Philipp Zabel wrote:
> Am Donnerstag, den 18.12.2014, 15:11 +0800 schrieb Liu Ying:
>> This patch supports the video_27m clock which is a fixed factor
>> clock of the pll3_pfd1_540m clock.
>>
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>> ---
>> v1->v2:
>>   * None.
>>
>>   arch/arm/mach-imx/clk-imx6q.c             | 1 +
>>   include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
>> index 4e79da7..9470df3 100644
>> --- a/arch/arm/mach-imx/clk-imx6q.c
>> +++ b/arch/arm/mach-imx/clk-imx6q.c
>> @@ -246,6 +246,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>>   	clk[IMX6QDL_CLK_PLL3_60M]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8);
>>   	clk[IMX6QDL_CLK_TWD]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
>>   	clk[IMX6QDL_CLK_GPT_3M]    = imx_clk_fixed_factor("gpt_3m",    "osc",            1, 8);
>> +	clk[IMX6QDL_CLK_VIDEO_27M] = imx_clk_fixed_factor("video_27m", "pll3_pfd1_540m", 1, 20);
>
> The HDMI TX isfr clock input is sourced from video_27m, too, according
> to Table 33-1 "HDMI clocks".
> I think the parent of clk[IMX6QDL_CLK_HDMI_ISFR] should be changed from
> "pll3_pfd1_540m" to "video_27m", then.

I'll add a new patch in the next version to change the hdmi_isfr
clock's parent.

Thanks,
Liu Ying

>
> regards
> Philipp
>
