From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 29 Nov 2013 16:56:08 +0200
Subject: [PATCH 2/2] memory: ti-aemif: add bindings for AEMIF driver
In-Reply-To: <20131122184247.GO14627@ns203013.ovh.net>
References: <1384962416-14862-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384962416-14862-3-git-send-email-ivan.khoronzhuk@ti.com>
 <20131120182102.GK14627@ns203013.ovh.net> <528D076A.8070806@ti.com>
 <20131122184247.GO14627@ns203013.ovh.net>
Message-ID: <5298AB08.3090108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On 11/22/2013 08:42 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 21:03 Wed 20 Nov     , ivan.khoronzhuk wrote:
>> On 11/20/2013 08:21 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> +				the chip select signal.
>>>> +				Minimum value is 1 (0 treated as 1).
>>>> +
>>>> +- ti,cs-wsetup:		write setup width, ns
>>>> +				Time between the beginning of a memory cycle
>>>> +				and the activation of write strobe.
>>>> +				Minimum value is 1 (0 treated as 1).
>>>> +
>>>> +- ti,cs-wstrobe:	write strobe width, ns
>>>> +				Time between the activation and deactivation of
>>>> +				the write strobe.
>>>> +				Minimum value is 1 (0 treated as 1).
>>>> +
>>>> +- ti,cs-whold:		write hold width, ns
>>>> +				Time between the deactivation of the write
>>>> +				strobe and the end of the cycle (which may be
>>>> +				either an address change or the deactivation of
>>>> +				the chip select signal.
>>>> +				Minimum value is 1 (0 treated as 1).
>>>> +
>>>> +If any of the above parameters are absent, current parameter value will be taken
>>>> +from the corresponding HW reg.
>>>> +
>>>> +The name for cs node must be in format csN, where N is the cs number.
>>>
>>> this is wired we should use reg instead to represent the cs as done for SPI
>>> or a an other property
>>>
>>> Best Regards,
>>> J.
>>>
>>
>> Ok, I will add new property cs-chipselect like following :
>>
>> ti,cs-chipselect:	number of chipselect. Indicates on the
>> 			aemif driver which chipselect is used
>> 			for accessing the memory.
>> 			For compatibles "ti,davinci-aemif" and
>> 			"ti,keystone-aemif" it can be in range [0-3].
>> 			For compatible "ti,omap-L138-aemif" range is [2-5].
>>
>> Is it OK?
> 
> yes
> 
> I just have one issue the whole memory concept
> 
> for me we should do as done on pinctrl have a phandle on the device that
> require it and handle it at device core level
> 
> as the memory controller is not necessarely on the same bus as the memory
> device them selves

Could you clarify your point a bit, pls?
Are you talking about external ASRAM, NOR and NAND chips wired to CS interface?

Regards,
- grygorii
