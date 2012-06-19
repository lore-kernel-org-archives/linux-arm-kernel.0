From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 19 Jun 2012 10:52:43 +0530
Subject: [PATCH 01/29] clk: Add support for rate table based dividers
In-Reply-To: <20120618200442.GA4402@gmail.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-2-git-send-email-rnayak@ti.com>
 <20120618200442.GA4402@gmail.com>
Message-ID: <4FE00CA3.5080309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 June 2012 01:34 AM, Mike Turquette wrote:
> On 20120614-18:16, Rajendra Nayak wrote:
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index e548c43..e4911ee 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -32,30 +32,69 @@
>>   #define div_mask(d)	((1<<  (d->width)) - 1)
>>   #define is_power_of_two(i)	!(i&  ~i)
>>
>> +static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
>> +{
>> +	unsigned int maxdiv;
>> +	const struct clk_div_table *clkt;
>> +
>> +	for (clkt = table; clkt->div; clkt++)
>> +		if (clkt->div>  maxdiv)
>> +			maxdiv = clkt->div;
>> +	return maxdiv;
>> +}
>> +
>
> Hi Rajendra,
>
> During testing the compiler warns that maxdiv is uninitialized here.

Thanks Mike, I'll fix that up.

>
> Regards,
> Mike
