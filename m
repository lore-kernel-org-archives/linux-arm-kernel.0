From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 16 Sep 2013 19:39:40 +0100
Subject: [PATCH 3/6] Staging/iio/adc/touchscreen/MXS: simplify register
 access
In-Reply-To: <201309161017.31846.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
 <52358D71.2040905@kernel.org> <201309161017.31846.jbe@pengutronix.de>
Message-ID: <5237506C.4010607@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/13 09:17, J?rgen Beisert wrote:
> Hi Jonathan,
> 
> On Sunday 15 September 2013 12:35:29 Jonathan Cameron wrote:
>> [...]
>>> +static void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 reg)
>>> +{
>>> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
>>> +}
>>> +
>>> +static void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val, u32 reg)
>>> +{ 
>>> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
>>> +}
>>> +
>>
>> mxs_lradc_reg_write might be clearer?
> 
> I would prefer the shorter name. Due to long macro names and long function 
> names the lines in the code below needs more and more line breaks which is 
> IMHO less helpfull to read the code.
Hmm.  It's not entirely obvious what else this might be doing, but it is
also not obvious from the name that it is writing to the register...

I remain unconvinced by the short name!
