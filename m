From: alex.elder@linaro.org (Alex Elder)
Date: Thu, 26 Dec 2013 09:02:09 -0600
Subject: [PATCH] clk: support hardware-specific debugfs entries
In-Reply-To: <20131226145052.GM8064@book.gsilab.sittig.org>
References: <52BC3CA1.7000701@linaro.org>
 <20131226145052.GM8064@book.gsilab.sittig.org>
Message-ID: <52BC44F1.9030205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26/2013 08:50 AM, Gerhard Sittig wrote:
> On Thu, Dec 26, 2013 at 08:26 -0600, Alex Elder wrote:
>>
>> @@ -140,6 +147,9 @@ struct clk_ops {
>>  	int		(*set_rate)(struct clk_hw *hw, unsigned long,
>>  				    unsigned long);
>>  	void		(*init)(struct clk_hw *hw);
>> +#ifdef CONFIG_COMMON_CLK_DEBUG
>> +	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
>> +#endif
>>  };
> 
> Please note that this CONFIG_COMMON_CLK_DEBUG switch may go away
> (or get replaced) soon.  Mike plans to effectively enable common
> clock debugging as soon as debugfs is in effect (which I welcome
> very much).

Fine with me.  I'll wait for further feedback before sending
out an updated patch.  Thanks.

					-Alex

> 
> So you should monitor current development and adjust your patch,
> or be prepared for breakage and fixing afterwards.  I'd suggest
> to just declare the .debug_init member unconditionally now.
> Since Mike's patch very likely gets accepted, and nothing will
> break when yours gets added later (regardless of the number of
> review iterations it will see).
> 
> 
> virtually yours
> Gerhard Sittig
> 
