From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 28 Dec 2009 11:24:19 -0500
Subject: [PATCH 1/5] arch/arm: Correct NULL test
In-Reply-To: <Pine.LNX.4.64.0912272307310.20548@ask.diku.dk>
References: <Pine.LNX.4.64.0912272226360.20548@ask.diku.dk><20091227215106.GA18317@pengutronix.de>
	<Pine.LNX.4.64.0912272307310.20548@ask.diku.dk>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F461@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 27, 2009 3:08 PM, Julia Lawall wrote:
>>>  	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
>>>  			     GFP_KERNEL);
>>> -	if (!dbgfs_state)
>>> +	if (!dbgfs_chan)
>>>  		goto err_alloc;
>> Shouldn't the malloc line read:
>> 
>> 	... = kmalloc(sizeof(*dbgfs_chan) * ...)
>> 	                      ^^^^^^^^^^
>> 
>> ?
>
> Good point, thanks.  I will send a revised patch.

Wouldn't this be clearer?

	... = kmalloc(sizeof(struct dentry) * ...)

Regards,
Hartley
