From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 12 Jul 2010 13:20:22 +0300
Subject: [PATCH 1/5] cpufreq-pxa3xx: use HSIO 312MHz on the pxa310
In-Reply-To: <AANLkTinI5mJZfQm_Ewd7qShSkB3jlsdJIiiA_W1E2F0s@mail.gmail.com>
References: <201007081904.01464.pieterg@gmx.com>
	<201007091031.44681.pieterg@gmx.com>
	<4C396F4E.3080704@compulab.co.il>
	<201007121037.14387.pieterg@gmx.com>
	<4C3ADCD4.7080608@compulab.co.il>
	<AANLkTinI5mJZfQm_Ewd7qShSkB3jlsdJIiiA_W1E2F0s@mail.gmail.com>
Message-ID: <4C3AEC66.4090907@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/10 12:29, Eric Miao wrote:
> On Mon, Jul 12, 2010 at 5:13 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>   
>>
>> On 07/12/10 11:37, pieterg wrote:
>>     
>>> On Sunday 11 July 2010 09:14:22 Igor Grinberg wrote:
>>>
>>>       
>>>> On 07/09/10 11:31, pieterg wrote:
>>>>
>>>>         
>>>>> On Friday 09 July 2010 10:02:16 Eric Miao wrote:
>>>>>
>>>>>           
>>>>>> What's wrong with 208MHz HSS on PXA310?
>>>>>>
>>>>>>             
>>>>> I haven't done any benchmarking, but Marvell found it worth to
>>>>> introduce 312MHz for the pxa310. (I assume it might have something to
>>>>> do with the video accelerator, which is unique to the pxa310).
>>>>>
>>>>> And to me it makes sense to use the highest supported speeds in the top
>>>>> cpufreq entry.
>>>>>
>>>>>           
>>>> According to Marvell's PXA3xx Specification Update document
>>>> (page 68 - SCr#3), the above is correct starting from silicon revision
>>>> A2. What about earlier revisions? Shouldn't we support all of them?
>>>>
>>>>         
>>> OK, I missed that. In that case we should leave this one out.
>>>
>>>       
>> If you really want this to go, you can check the cpu stepping (cpuid
>> register)
>> and fixup the table accordingly. Something like:
>>
>> if (cpu_is_pxa310())
>>        ret = setup_freqs_table(policy, (read_cpuid_id() & 0xf) ?
>>
>> ARRAY_AND_SIZE(pxa310_freqs) :
>>
>> ARRAY_AND_SIZE(pxa300_freqs));
>>
>> but I don't know if Eric will like it ;)
>>
>>     
> Nah, I was thinking of introducing a cpu_is_pxa310_a2() or something,
> but that's really hard to make generic, since for this case, we'd
> have to use cpu_is_pxa310_a2_or_above(), which is #!$!%!@#$
>
> So to put it simple, I think a command line parameter would make
> more sense in this case. e.g. pxa310_use_312mhz.
>   

Indeed, command line parameter pxa310.hss=312/208 sounds good

>   
>>> Rgds, Pieter
>>>
>>>
>>>       
>> --
>> Regards,
>> Igor.
>>
>>
>>     
>   

-- 
Regards,
Igor.
