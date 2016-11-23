From: scott.wood@nxp.com (Scott Wood)
Date: Wed, 23 Nov 2016 07:21:18 +0000
Subject: [PATCH] clk: qoriq: added ls1012a clock configuration
References: <1479275900-42365-1-git-send-email-yuantian.tang@nxp.com>
 <1479279262.21746.40.camel@buserror.net>
 <DB6PR0402MB28371BAAD862417B8AC8AED4F0B40@DB6PR0402MB2837.eurprd04.prod.outlook.com>
Message-ID: <DB5PR0401MB1928F7FFBDB7D6E4C4B45D9491B70@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2016 02:20 AM, Y.T. Tang wrote:
> Hi Scott,
> 
>> -----Original Message-----
>> From: Scott Wood [mailto:oss at buserror.net]
>> Sent: Wednesday, November 16, 2016 2:54 PM
>> To: Y.T. Tang <yuantian.tang@nxp.com>; mturquette at baylibre.com
>> Cc: sboyd at codeaurora.org; linux-kernel at vger.kernel.org; Scott Wood
>> <scott.wood@nxp.com>; linux-clk at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH] clk: qoriq: added ls1012a clock configuration
>>
>> On Wed, 2016-11-16 at 13:58 +0800, yuantian.tang at nxp.com wrote:
>>> From: Tang Yuantian <Yuantian.Tang@nxp.com>
>>>
>>> Added ls1012a clock configuation information.
>>
>> Do we really need the same line in the changelog twice?
>>
>>>
>>> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
>>> ---
>>>  drivers/clk/clk-qoriq.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c index
>>> 1bece0f..563d874 100644
>>> --- a/drivers/clk/clk-qoriq.c
>>> +++ b/drivers/clk/clk-qoriq.c
>>> @@ -202,6 +202,14 @@ static const struct clockgen_muxinfo ls1021a_cmux
>> = {
>>>  	}
>>>  };
>>>
>>> +static const struct clockgen_muxinfo ls1012a_cmux = {
>>> +	{
>>> +		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
>>> +		{},
>>> +		[2] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
>>> +	}
>>> +};
>>> +
>>
>> Based on the "ls1021a_cmux" in the context it looks like this patch is
>> intended to apply on top
>> of https://patchwork.kernel.org/patch/8923541/ but I don't see any mention
>> of that.
>>
> I saw this patch had been merged already.
> 
> Regards,
> Yuantian

I don't see it in linux-next.

-Scott
