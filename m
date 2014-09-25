From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 25 Sep 2014 09:35:30 +0800
Subject: [PATCH] clk: rockchip: add missing rk3288 npll rate table
In-Reply-To: <CAD=FV=WCZt5cQ3Z4wWHyqgOh32X-Hztnyzs3-fpXh2nj7ROyfQ@mail.gmail.com>
References: <1631893.xHvKLXVMyM@phil>
 <CAD=FV=WCZt5cQ3Z4wWHyqgOh32X-Hztnyzs3-fpXh2nj7ROyfQ@mail.gmail.com>
Message-ID: <54237162.5030601@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,

On 09/25/2014 06:51 AM, Doug Anderson wrote:
> Heiko,
>
> On Wed, Sep 24, 2014 at 2:41 PM, Heiko St?bner <heiko@sntech.de> wrote:
>> The npll on rk3288 is exactly the same pll type as the other 4. Yet it
>> was missing the link to the rate table, making rate changes impossible.
>> Change that by setting the table.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>   drivers/clk/rockchip/clk-rk3288.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
>> index 8ea885b..938d30b 100644
>> --- a/drivers/clk/rockchip/clk-rk3288.c
>> +++ b/drivers/clk/rockchip/clk-rk3288.c
>> @@ -143,7 +143,7 @@ static struct rockchip_pll_clock rk3288_pll_clks[] __initdata = {
>>          [gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK3288_PLL_CON(12),
>>                       RK3288_MODE_CON, 12, 8, rk3288_pll_rates),
>>          [npll] = PLL(pll_rk3066, PLL_NPLL, "npll",  mux_pll_p, 0, RK3288_PLL_CON(16),
>> -                    RK3288_MODE_CON, 14, 9, NULL),
>> +                    RK3288_MODE_CON, 14, 9, rk3288_pll_rates),
>>   };
> Works for me.  Any reason not to add it to dpll, too?
dpll is used for DDR controller only, I'm not sure memory scaling driver 
will use
the clock module API, because the code for memory scaling must moved to 
intmem
(dram is not available at that time), which need to be small enough, and 
it's not
possible to use the API from clock module.

So, I think it is no need to add the rate table to dpll.

-Kever
