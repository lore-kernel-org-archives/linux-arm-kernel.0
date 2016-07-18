From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Jul 2016 17:13:17 -0600
Subject: [PATCH V2 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <5783C468.2030708@wwwdotorg.org>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-2-josephl@nvidia.com>
 <20160707181356.GA6864@kickseed.nvidia.com> <577EA0D6.9020308@wwwdotorg.org>
 <20160711141407.GA25042@rob-hp-laptop> <5783C468.2030708@wwwdotorg.org>
Message-ID: <578D628D.60802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2016 10:08 AM, Stephen Warren wrote:
> On 07/11/2016 08:14 AM, Rob Herring wrote:
>> On Thu, Jul 07, 2016 at 12:35:02PM -0600, Stephen Warren wrote:
>>> On 07/07/2016 12:13 PM, Sivaram Nair wrote:
>>>> On Tue, Jul 05, 2016 at 05:04:22PM +0800, Joseph Lo wrote:
>>>>> Add DT binding for the Hardware Synchronization Primitives (HSP). The
>>>>> HSP is designed for the processors to share resources and communicate
>>>>> together. It provides a set of hardware synchronization primitives for
>>>>> interprocessor communication. So the interprocessor communication
>>>>> (IPC)
>>>>> protocols can use hardware synchronization primitive, when operating
>>>>> between two processors not in an SMP relationship.
>>>
>>>>> diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h
>>>>> b/include/dt-bindings/mailbox/tegra186-hsp.h
>>>
>>>>> +#define HSP_MBOX_TYPE_DB 0x0
>>>>> +#define HSP_MBOX_TYPE_SM 0x1
>>>>> +#define HSP_MBOX_TYPE_SS 0x2
>>>>> +#define HSP_MBOX_TYPE_AS 0x3
>>>>> +
>>>>> +#define HSP_DB_MASTER_CCPLEX 17
>>>>> +#define HSP_DB_MASTER_BPMP 19
>>>>> +
>>>>> +#define HSP_MBOX_ID(type, ID) \
>>>>> +        (HSP_MBOX_TYPE_##type << 16 | ID)
>>>>
>>>> It will be nicer if you avoid the macro glue magic '##' for 'type'. I
>>>> would also suggest to use braces around 'type' and 'ID'.
>>>
>>> This technique been used without issue in quite a few other places
>>> without
>>> issue, and has the benefit of simplifying the text wherever the macro is
>>> used. What issue do you foresee?
>>
>> I'm not a fan of using the macros to begin with and less so anything
>> more complex than a single constant value. I'd rather see 2 cells here
>> with the first being the id and the 2nd being the type.
>>
>> An issue with token pasting is grepping for DB, SM, etc. in kernel tree
>> is probably noisy. Not such a big deal here, but a major PIA when you
>> have more complex sets of includes.
>
> Is that a NAK or simply a suggestion? Having a single cell makes DT
> parsing a bit simpler, since pretty much every SW stack provides a
> default "one-cell" of_xlate implementation, whereas >1 cell means custom
> code for of_xlate.

I didn't see a response to this. Joseph, let's just use two cells 
instead. I'm rather desperately waiting for this binding to be complete 
so I can finalize the U-Boot code that uses it, and it sounds like 
changing to two cells will get an ack faster. Can you post an updated 
version of this series today/ASAP to get things moving? Thanks.
