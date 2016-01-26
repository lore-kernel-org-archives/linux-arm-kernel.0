From: blogic@openwrt.org (John Crispin)
Date: Tue, 26 Jan 2016 08:14:45 +0100
Subject: [PATCH V2 4/4] mfd: mediatek: add MT6323 support to MT6397 driver
In-Reply-To: <1453777643.26374.11.camel@mtksdaap41>
References: <1453716887-38442-1-git-send-email-blogic@openwrt.org>
 <20160125124112.GG3368@x1> <56A64108.7020807@openwrt.org>
 <3476571.0yU9yvPsKF@linux-gy6r.site> <56A670A3.5030100@openwrt.org>
 <1453777643.26374.11.camel@mtksdaap41>
Message-ID: <56A71CE5.4080201@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/01/2016 04:07, Henry Chen wrote:
> On Mon, 2016-01-25 at 19:59 +0100, John Crispin wrote:
>>
>> On 25/01/2016 19:44, Matthias Brugger wrote:
>>> On Monday 25 Jan 2016 16:36:40 John Crispin wrote:
>>>> Hi,
>>>>
>>>> On 25/01/2016 13:41, Lee Jones wrote:
>>>>> Please honour the subject format of the subsystem you are contributing
>>>>> to.
>>>>>
>>>>> `git log --oneline -- $subsystem` gives you this.
>>>>>
>>>>> On Mon, 25 Jan 2016, John Crispin wrote:
>>>>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>>> @@ -261,6 +271,15 @@ static int mt6397_probe(struct platform_device
>>>>>> *pdev)
>>>>>>
>>>>>>  	}
>>>>>>  	
>>>>>>  	switch (id & 0xff) {
>>>>>>
>>>>>> +	case MT6323_CID_CODE:
>>>>>> +		mt6397->int_con[0] = MT6323_INT_CON0;
>>>>>
>>>>> This is confusing.  You're still using memory allocated for a mt6397
>>>>> device.
>>>>
>>>> the variable is currently defined as struct mt6397_chip *mt6397;
>>>> shall i only change the name or also create a patch to rename the struct ?
>>>>
>>>
>>> I think we should rename the struct and the file as well.
>>>
>>> Cheers,
>>> Matthias
>>
>> Hi,
>>
>> that would have been my next question. renaming the struct would imply
>> renaming the driver and the whole namespace contained within. We would
>> then also need to change the Kconfig and Makefile. I am happy to do this
>> but want to be sure that is is actually wanted.
>>
>> 	John
> Hi,
> 
> Since mt6323 was similar with mt6397, I think we can reuse the
> mt6397_chip without duplicate code.
> 
> Maybe we can rename the local variable name to avoid confusing.
> 
> struct mt6397_chip *mt_pmic;
> ...
> ...
> switch (id & 0xff) {
> 	case MT6323_CID_CODE:
> 		mt_pmic->int_con[0] = MT6323_INT_CON0;
> 		mt_pmic->int_con[1] = MT6323_INT_CON1;
> ...
> ...
> 
> Henry

Hi,

IMHO we should either rename the namespace or not. renaming some
variables seems weird as that will just move the confusion/inconsistency
to another place in the code. I am however rather indifferent on this
matter.

	John
