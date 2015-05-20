From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 20 May 2015 10:56:28 -0300
Subject: [PATCH v5 05/12] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <20150520135531.GK22054@kwain>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431356341-31640-6-git-send-email-antoine.tenart@free-electrons.com>
 <555128F0.30702@vanguardiasur.com.ar> <20150512143943.GC32171@kwain>
 <5557B54B.9010307@vanguardiasur.com.ar> <20150520135531.GK22054@kwain>
Message-ID: <555C928C.1010909@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/20/2015 10:55 AM, Antoine Tenart wrote:
> On Sat, May 16, 2015 at 06:23:23PM -0300, Ezequiel Garcia wrote:
>> On 05/12/2015 11:39 AM, Antoine Tenart wrote:
>>> On Mon, May 11, 2015 at 07:10:56PM -0300, Ezequiel Garcia wrote:
>>>>
>>>> On 05/11/2015 11:58 AM, Antoine Tenart wrote:
>>>> [..]
>>>>> -
>>>>> -	/* calculate flash information */
>>>>> -	host->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
>>>>> -
>>>>
>>>> [..]
>>>>> @@ -1732,6 +1669,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
>>>>>  		host->mtd = mtd;
>>>>>  		host->cs = cs;
>>>>>  		host->info_data = info;
>>>>> +		host->read_id_bytes = 4;
>>>>
>>>> Are you sure this is correct? The value is set according to the page
>>>> size before this patch.
>>>
>>> Before reading the ID, the pxa3xx driver uses a default configuration,
>>> builtin_flash_types[0], which defines a page size of 2048 leading to set
>>> host->read_id_bytes to 4.
>>>
>>> I'm using this default value here.
>>>
>>> There might be an issue, as host->read_id_bytes isn't updated after
>>> reading the ID (and getting the actual page size). I don't know if this
>>> can be a problem. I can modify pxa3xx_nand_config_flash() to update
>>> host->read_id_bytes if needed. What do you think?
>>>
>>
>> Well, once the device is detected, READ_ID shouldn't be used, so I'm not
>> sure what's the point of that.
> 
> I don't think there's a need to update read_id_bytes once the device is
> detected. Why don't we stay with 4?
> 

Sure, that's exactly what I was saying.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
