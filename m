From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 18 Jun 2014 00:11:40 +0200
Subject: [patch] char: xilinx_hwicap: missing error code if ioremap() fails
In-Reply-To: <20140617060324.GS5015@mwanda>
References: <20140611060433.GB7569@mwanda>
 <000001cf8540$017e4f90$047aeeb0$%han@samsung.com>
 <add7f4d9-0279-4c49-b936-d70f34008ab4@BY2FFO11FD044.protection.gbl>
 <20140617060324.GS5015@mwanda>
Message-ID: <087c9c34-0a21-4116-8179-174551750d4e@BY2FFO11FD026.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2014 08:03 AM, Dan Carpenter wrote:
> On Tue, Jun 17, 2014 at 02:53:27AM +0200, Michal Simek wrote:
>> On 06/11/2014 08:40 AM, Jingoo Han wrote:
>>> On Wednesday, June 11, 2014 3:05 PM, Dan Carpenter wrote:
>>>>
>>>> Return -ENOMEM instead of success if ioremap() fails.
>>>>
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
>>>
>>> Best regards,
>>> Jingoo Han
>>>
>>>> ---
>>>> Static checker stuff, I can't compile this.
>>>>
>>>> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
>>>> index f6345f9..9b1a5ac 100644
>>>> --- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
>>>> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
>>>> @@ -661,6 +661,7 @@ static int hwicap_setup(struct device *dev, int id,
>>>>  	drvdata->base_address = ioremap(drvdata->mem_start, drvdata->mem_size);
>>>>  	if (!drvdata->base_address) {
>>>>  		dev_err(dev, "ioremap() failed\n");
>>>> +		retval = -ENOMEM;
>>
>> Isn't it just better to do?
>>
>> if (IS_ERR(drvdata->base_address)) {
>> 	...
>> 	retval = PTR_ERR(drvdata->base_address);
>> }
> 
> ioremap() returns NULL on error, not an ERR_PTR.

Ah ok. Fair enough.

Thanks,
Michal
