From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 17 Oct 2015 08:49:48 +0800
Subject: [PATCH 01/10] clk: rockchip: Add sclk_mipidsi_24m for mipi dsi
In-Reply-To: <20151016213940.GA10182@codeaurora.org>
References: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
 <1444470930-17150-2-git-send-email-zyw@rock-chips.com>
 <20151016213940.GA10182@codeaurora.org>
Message-ID: <56219B2C.8090902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/17/2015 05:39 AM, Stephen Boyd wrote:
> On 10/10, Chris Zhong wrote:
>> sclk_mipidsi_24m is the gating of mipi dsi phy.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> ---
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>
>>   drivers/clk/rockchip/clk-rk3288.c      | 2 +-
>>   include/dt-bindings/clock/rk3288-cru.h | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
>> index 9040878..c7d7ebf 100644
>> --- a/drivers/clk/rockchip/clk-rk3288.c
>> +++ b/drivers/clk/rockchip/clk-rk3288.c
>> @@ -709,7 +709,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>>   	GATE(SCLK_LCDC_PWM1, "sclk_lcdc_pwm1", "xin24m", 0, RK3288_CLKGATE_CON(13), 11, GFLAGS),
>>   	GATE(SCLK_PVTM_CORE, "sclk_pvtm_core", "xin24m", 0, RK3288_CLKGATE_CON(5), 9, GFLAGS),
>>   	GATE(SCLK_PVTM_GPU, "sclk_pvtm_gpu", "xin24m", 0, RK3288_CLKGATE_CON(5), 10, GFLAGS),
>> -	GATE(0, "sclk_mipidsi_24m", "xin24m", 0, RK3288_CLKGATE_CON(5), 15, GFLAGS),
>> +	GATE(SCLK_MIPI_24M, "sclk_mipidsi_24m", "xin24m", 0, RK3288_CLKGATE_CON(5), 15, GFLAGS),
>>   
> It would have been better to make #defines for all these clocks
> even if they weren't going to be used here. Then we could have
> applied this patch directly to clk tree without having a clk tree
> to arm-soc dependency. </grumble>
>
Thanks for your great suggestion, I'll defines all clocks at next 
version patch serial
