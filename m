From: gang.chen@asianux.com (Chen Gang)
Date: Sat, 12 Oct 2013 09:36:44 +0800
Subject: [PATCH] arm/arm64: remove atomic_clear_mask() in
 "include/asm/atomic.h"
In-Reply-To: <5257F710.5090706@nod.at>
References: <5256121A.9030504@asianux.com> <52561269.60900@asianux.com>
 <20131010100733.GH3817@mudshark.cambridge.arm.com>
 <52568998.2080108@asianux.com>
 <20131010142305.GG6199@mudshark.cambridge.arm.com>
 <525751E2.3020207@asianux.com>
 <20131011104419.GE14732@mudshark.cambridge.arm.com>
 <5257E033.3090607@asianux.com> <5257E539.9080902@asianux.com>
 <CAFLxGvwsx2YfNHiGtjWsANfVW74PT3KneLA-T6SpY4NEp_OSUA@mail.gmail.com>
 <20131011122846.GK14732@mudshark.cambridge.arm.com> <5257F710.5090706@nod.at>
Message-ID: <5258A7AC.4060902@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2013 09:03 PM, Richard Weinberger wrote:
> Am 11.10.2013 14:28, schrieb Will Deacon:
>> On Fri, Oct 11, 2013 at 01:08:17PM +0100, Richard Weinberger wrote:
>>> On Fri, Oct 11, 2013 at 1:47 PM, Chen Gang <gang.chen@asianux.com> wrote:
>>>> In current kernel wide source code, except other architectures, only
>>>> s390 scsi drivers use atomic_clear_mask(), and arm/arm64 need not
>>>> support s390 drivers.
>>>>
>>>> So remove atomic_clear_mask() from "arm[64]/include/asm/atomic.h".
>>>
>>> Is it really worth removing such a primitive?
>>> If someone needs it later he has to implement it from scratch and
>>> introduces bugs...
>>
>> The version we have (on ARM64 anyway) already has bugs. Given the choice
>> between fixing code that has no callers and simply removing it, I'd go for
>> the latter.
> 
> Yeah, if it's broken and has no real users, send it to hell. :)
> 

OK, thanks.


Hmm... at least, the original API definition is not well enough: "need
use 'unsigned int' and 'atomic_t' instead of 'unsigned long' for the
type of parameters".

But can we say "under arm64, it must be a bug"? (although I agree it is
very easy to let callers miss using it -- then may cause issue).

In my opinion, it belongs to "API definition issue" not implementation
bug: "if all callers are carefully enough, it will not make issues"
(e.g. in "./kernel" sub-system, we can meet many such kinds of things).



Thanks.

> Thanks,
> //richard
> 
> 
> 

-- 
Chen Gang
