From: s-anna@ti.com (Suman Anna)
Date: Thu, 11 Aug 2016 15:09:29 -0500
Subject: [PATCH 1/9] remoteproc: core: Ensure error message is clear
In-Reply-To: <20160811191911.GB26240@tuxbot>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-2-lee.jones@linaro.org> <20160809172825.GB26240@tuxbot>
 <20160809181243.GC1581@dell> <68ec0dd7-676d-47a9-19ba-9dcfc9569902@ti.com>
 <20160811073657.GB1715@dell> <20160811191911.GB26240@tuxbot>
Message-ID: <554c99db-1f4f-86f4-cde6-b375244c47f4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2016 02:19 PM, Bjorn Andersson wrote:
> On Thu 11 Aug 00:36 PDT 2016, Lee Jones wrote:
> 
>> On Wed, 10 Aug 2016, Suman Anna wrote:
>>
>>> On 08/09/2016 01:12 PM, Lee Jones wrote:
>>>> On Tue, 09 Aug 2016, Bjorn Andersson wrote:
>>>>
>>>>> On Thu 04 Aug 02:21 PDT 2016, Lee Jones wrote:
> [..]
>>>>>> -	dev_dbg(dev, "carveout rsc: da %x, pa %x, len %x, flags %x\n",
>>>>>> +	dev_dbg(dev, "carveout rsc: da %x, pa %x, len 0x%x, flags %x\n",
>>>>>>  			rsc->da, rsc->pa, rsc->len, rsc->flags);
>>>
>>> If you are modifying this trace, it's better to following the leading 0x
>>> convention on all arguments rather than just the length.
>>
>> I'd be concerned if anyone thought it a good idea to print out memory
>> addresses !0x.  The length is the only parameter there which could
>> (and has) cause confusion.
>>
>> However, the fix-up is trivial, so I'm happy to oblige.  I'll leave
>> the final decision to Bjorn and fix-up if he sees it necessary.
>>
> 
> I applied this patch yesterday, I see both changes here related to the
> issue presented (confusing printing of len) so I'm fine with not
> touching the other parts.
> 
> That said, there are a few other format strings in this driver that
> would benefit from some love as well, several cases where we should use
> %pK or %pad rather than using %llx and a cast to unsigned long long.

OK, no issues. I have the patches for some of these handy, will post
them soon.

regards
Suman
