From: david@lechnology.com (David Lechner)
Date: Mon, 7 May 2018 13:32:41 -0500
Subject: [PATCH v2 1/2] clk: davinci: pll-dm355: fix SYSCLKn parent names
In-Reply-To: <5805f462-0cb5-3024-f5af-941db8a46895@ti.com>
References: <20180507144307.32364-1-david@lechnology.com>
 <5805f462-0cb5-3024-f5af-941db8a46895@ti.com>
Message-ID: <f41e762d-273a-9e8a-579a-f43e90260020@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/7/18 10:21 AM, Sekhar Nori wrote:
> On Monday 07 May 2018 08:13 PM, David Lechner wrote:
>> This fixes the parent clock names of the SYSCLKn clocks for the DM355
>> SoC in the TI DaVinici PLL clock driver.
>>
>> It appears that this name just didn't get updated to the correct name
>> like the other SoCs during the driver's development.
>>
>> Reported-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v2 changes:
>> - add second patch to fix additional problems with DM355
>>
>>   drivers/clk/davinci/pll-dm355.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
>> index 5345f8286c50..1f746d2fc894 100644
>> --- a/drivers/clk/davinci/pll-dm355.c
>> +++ b/drivers/clk/davinci/pll-dm355.c
>> @@ -22,10 +22,10 @@ static const struct davinci_pll_clk_info dm355_pll1_info = {
>>   		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
>>   };
>>   
>> -SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> -SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> -SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED);
>> -SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
>>   
>>   int dm355_pll1_init(struct device *dev, void __iomem *base)
>>   {
>> @@ -62,8 +62,8 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
>>   		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
>>   };
>>   
>> -SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV);
>> -SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV);
>> +SYSCLK(2, pll2_sysclk2, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
> 
> Good find with PLL2 SYSCLK2. Can you reverse the patch order so we are
> not fixing up a non-existent clock?
> 

Sure. But it will take me a couple days to get back to it.
