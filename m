From: marex@denx.de (Marek Vasut)
Date: Thu, 4 May 2017 16:34:14 +0200
Subject: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
In-Reply-To: <20170504134100.GR18578@dragon>
References: <20170503135715.GG18578@dragon>
 <76e22a7e-590f-00ee-04f8-87604303eaad@denx.de>
 <1493823533.11226.28.camel@nxp.com>
 <e46a57c2-4a28-a8b6-445e-299dd9d8659c@denx.de>
 <1493834298.11226.40.camel@nxp.com>
 <51fb1bd0-028d-c431-acc8-3c4f1d25fdba@denx.de>
 <1493890943.11226.42.camel@nxp.com>
 <6dbf67a0-42ea-ee84-d144-41422a21c1c5@denx.de>
 <20170504124446.GO18578@dragon>
 <4ba6bdf2-56b2-972d-3326-0eda3985c80b@denx.de>
 <20170504134100.GR18578@dragon>
Message-ID: <8c3827c4-1272-f004-52d9-7c79e93813c6@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2017 03:41 PM, Shawn Guo wrote:
> On Thu, May 04, 2017 at 03:08:41PM +0200, Marek Vasut wrote:
>> On 05/04/2017 02:44 PM, Shawn Guo wrote:
>>> On Thu, May 04, 2017 at 12:06:11PM +0200, Marek Vasut wrote:
> 
> <snip>
> 
>>>> Mind you, my patch is not fixing any crash, it's correcting the
>>>> regulator binding and removing the OPP override which is at that
>>>> point useless.
>>>
>>> Heh, that's the primary reason why I prefer Leonard's patch, as his
>>> patch is fixing a critical crash issue, while yours is just removing
>>> some useless stuff and correcting something that doesn't show any real
>>> problem.
>>
>> Maybe you want to compare those two patches again, his patch fixing the
>> critical crash is removing the same "some useless stuff" as mine.
> 
> The difference is in commit message.  From your commit message, people
> do not see what real world user noticeable issue your patch is fixing.
> 
>> Plus
>> mine is actually making sure the regulators are configured correctly,
>> not just removing "some useless stuff" and hoping for the best that
>> bootloader will do the right thing.
> 
> Without this part, we do not get anything worse.  That said, it can be
> an improvement in another patch.
> 
>>>> Which part of the following commit message is unclear?
>>>>
>>>> "
>>>> The imx6sx-sdb has one power supply that drives both VDDARM_IN
>>>> and VDDSOC_IN, which is the sw1a regulator on the PFUZE PMIC.
>>>> Connect both inputs to the sw1a regulator on the PMIC and drop
>>>> the OPP hackery which is no longer needed as the power framework
>>>> will take care of the regulator configuration as needed.
>>>> "
>>>
>>> Something unclear in my opinion:
>>>
>>>  - The OPP hackery was never needed, as it's only needed for LDO bypass
>>>    mode which hasn't been supported by mainline kernel.  It's not 'no
>>>    longer needed as the power framework ...'.
>>
>> I don't know what this is about, it's not from my patch either ...
> 
> So I guess you do not understand how the OPP hackery was born and why it
> shouldn't be there for mainline kernel at all.

The OPP hackery is there to keep both regulators configured the same
way, since they share the same input voltage rail IMO. If you model the
power distribution correctly, the OPP hackery can be removed.

>>>  - What are the related changes in power framework?  It will be more
>>>    clear if we can have the particular commit mentioned here.
>>
>> Uh, I don't understand your question, there are no new changes in the
>> power framework. The DT for the SDB was always wrong, my patch fixes it.
> 
> Then 'no longer needed' in your commit message is really confusing.
> 
> Shawn
> 


-- 
Best regards,
Marek Vasut
