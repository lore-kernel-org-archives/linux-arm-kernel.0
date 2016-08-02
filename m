From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 2 Aug 2016 09:50:05 +0800
Subject: [RESEND PATCH v2 3/8] clk: rockchip: rk3399: fix incorrect parent
 for rk3399's {c, g}pll_aclk_perihp_src
In-Reply-To: <20160801201349.GA129313@google.com>
References: <1470045224-31854-1-git-send-email-zhengxing@rock-chips.com>
 <1470045224-31854-4-git-send-email-zhengxing@rock-chips.com>
 <20160801201349.GA129313@google.com>
Message-ID: <579FFC4D.2070406@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brain,

On 2016?08?02? 04:13, Brian Norris wrote:
> On Mon, Aug 01, 2016 at 05:53:38PM +0800, Xing Zheng wrote:
>> There was a typo, swapping 'c' <--> 'g'.
>> (This patch is updated and am from https://patchwork.kernel.org/patch/9254067/)
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2: None
> I believe this patch was already applied upstream; otherwise, it
> wouldn't make sense to have both this patch and patch 4 -- we would
> probably squash them together.
>
> Brian
>
Yes, this patch is applied in mmind/linux-rockchip.git v4.7-clk/fixes, I 
arm sorry to tracked on v4.8-clk/next so that didn't note it.
This patch will be abandoned.

Thanks.

>>   drivers/clk/rockchip/clk-rk3399.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
>> index f55f967f..2182391 100644
>> --- a/drivers/clk/rockchip/clk-rk3399.c
>> +++ b/drivers/clk/rockchip/clk-rk3399.c
>> @@ -832,9 +832,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>>   			RK3399_CLKGATE_CON(13), 1, GFLAGS),
>>   
>>   	/* perihp */
>> -	GATE(0, "cpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
>> +	GATE(0, "cpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
>>   			RK3399_CLKGATE_CON(5), 0, GFLAGS),
>> -	GATE(0, "gpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
>> +	GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
>>   			RK3399_CLKGATE_CON(5), 1, GFLAGS),
>>   	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IGNORE_UNUSED,
>>   			RK3399_CLKSEL_CON(14), 7, 1, MFLAGS, 0, 5, DFLAGS,
>> -- 
>> 1.7.9.5
>>
>>
>
>

-- 
- Xing Zheng
