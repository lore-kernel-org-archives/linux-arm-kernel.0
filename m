From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 8 Dec 2014 21:48:04 +0800
Subject: [PATCH v14 7/7] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <1418044934.3647.61.camel@linaro.org>
References: <1418020040-68977-1-git-send-email-wangnan0@huawei.com>			
 <1418020131-69375-1-git-send-email-wangnan0@huawei.com>		
 <1418036666.3647.33.camel@linaro.org> <5485886E.2060303@huawei.com>	
 <1418039451.3647.48.camel@linaro.org> <54859454.30603@huawei.com>	
 <54859A2C.8030009@huawei.com> <1418044934.3647.61.camel@linaro.org>
Message-ID: <5485AC14.1000207@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/12/8 21:22, Jon Medhurst (Tixy) wrote:
> On Mon, 2014-12-08 at 20:31 +0800, Wang Nan wrote:
>> On 2014/12/8 20:06, Wang Nan wrote:
>>> On 2014/12/8 19:50, Jon Medhurst (Tixy) wrote:
>>>> On Mon, 2014-12-08 at 19:15 +0800, Wang Nan wrote:
>>>>> On 2014/12/8 19:04, Jon Medhurst (Tixy) wrote:
>>>>>> On Mon, 2014-12-08 at 14:28 +0800, Wang Nan wrote:
>> [...]
>>>>
>>>> so another CPU could find and delete next before this one has finished
>>>> doing so. Would the list end up in a consistent state where no loops
>>>> develop and no probes are missed? I don't know the answer and a full
>>>> analysis would be complicated, but my gut feeling is that if a cpu can
>>>> observe the links in the list in an inconsistent state then only bad
>>>> things can result.
>>>>
>>>
>>> I see the problem.
>>>
>>> I'm thinking about making core.c and opt-arm.c to share stop_machine() code.
>>> stop_machine() is required when removing breakpoint, so I'd like to define
>>> a "remove_breakpoint" function in core.c and make opt-arm.c to call it.
>>> Do you think it is a good idea?
>>>
>>>
>>
>> What I mean is something like this:
> 
> Yes, that should work, though as remove_breakpoint is a globally visible
> symbol, I suggest a less generic name for it, perhaps
> remove_kprobe_breakpoint ?
> 

I don't think it is globally visible. Only files in arm/probes/kprobes
can include "core.h". However, I do agree that remove_breakpoint() is not
a good name. In my v15 patch, I'd like to rename it to kprobe_remove_breakpoint(),
due to may of names defined in core.h are called kprobes_xxx.

Thank you!
