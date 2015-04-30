From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Apr 2015 20:58:10 +0200
Subject: [PATCH 4/4] clk: si5351: Reset PLL after rate change
In-Reply-To: <20150430184932.GB22000@deathray>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1430415954-29517-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150430184932.GB22000@deathray>
Message-ID: <55427B42.9060902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.04.2015 20:49, Michael Welling wrote:
> On Thu, Apr 30, 2015 at 07:45:54PM +0200, Sebastian Hesselbarth wrote:
>> When changing PLL rate significantly, PLLs have to be reset. Add a function
>> to perform and check for successful PLL reset.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
[...]
>> @@ -519,6 +545,9 @@ static int si5351_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>>   		SI5351_CLK_INTEGER_MODE,
>>   		(hwdata->params.p2 == 0) ? SI5351_CLK_INTEGER_MODE : 0);
>>
>> +	/* reset pll after rate change */
>> +	si5351_pll_reset(hwdata);
>> +
>
> What is the point of having a return code if it is not being used?

Good point, I'll pass that on to the return value of .set_rate()
callback for v2.

Sebastian
