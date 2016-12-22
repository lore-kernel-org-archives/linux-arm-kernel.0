From: eric@anholt.net (Eric Anholt)
Date: Wed, 21 Dec 2016 17:23:18 -0800
Subject: [PATCH 02/11] clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
In-Reply-To: <20161221231446.GA8288@codeaurora.org>
References: <20161214194621.16499-1-eric@anholt.net>
 <20161214194621.16499-3-eric@anholt.net>
 <20161221231446.GA8288@codeaurora.org>
Message-ID: <871sx069kp.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 12/14, Eric Anholt wrote:
>>  
>>  	/* the gates */
>>  
>> @@ -1890,8 +1976,18 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
>>  	if (IS_ERR(cprman->regs))
>>  		return PTR_ERR(cprman->regs);
>>  
>> -	cprman->osc_name = of_clk_get_parent_name(dev->of_node, 0);
>> -	if (!cprman->osc_name)
>> +	for (i = 0; i < ARRAY_SIZE(cprman_parent_names); i++) {
>> +		cprman->real_parent_names[i] =
>> +			of_clk_get_parent_name(dev->of_node, i);
>> +	}
>
> Can we use of_clk_parent_fill() here? Or do we need to support
> holes in the parent array? If it's the latter please add a
> comment so we don't mistakenly change this later.

It looks like that will work fine.  We'll only be missing parents from
the end of the array.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161221/0343dbad/attachment.sig>
