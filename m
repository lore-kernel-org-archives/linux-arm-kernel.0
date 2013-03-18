From: miloody@gmail.com (loody)
Date: Mon, 18 Mar 2013 17:38:11 +0800
Subject: some question about monitor mode support in arm
In-Reply-To: <5141D298.6010401@codeaurora.org>
References: <CANudz+tPrFxUEhzbpdVYnhnzKnJJ2wsJ7s_3YAWiOUJjJhQ3YA@mail.gmail.com>
 <5141D298.6010401@codeaurora.org>
Message-ID: <CANudz+u2kEJRu0P1oVv84AhuGXM8RW-inr=LrPp4WJSKYQ3iJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Christopher:

2013/3/14 Christopher Covington <cov@codeaurora.org>:
> Hi,
>
> On 03/14/2013 05:43 AM, loody wrote:
>> Hi all:
>> Does linux kernel support monitor mode handling?
>
> It does not, but hypervisor mode support was recently added, which has pretty
> similar mechanics.
>
>> I grep the keyword 'smc' but it only show how switch to, such as
>> mach-highbank/smc.S,
>> but not seem where to handle it.
>
> You can take a look at __hyp_set_vectors in arch/arm/kernel/hyp-stub.S for one
> example of setting up exception vectors.
I grep what you mentioned.
But it seems nothing about __hyp_set_vectors you described
in arch/arm/kernel/hyp-stub.S
ENTRY(__hyp_set_vectors)
        __HVC(0)
        mov     pc, lr
ENDPROC(__hyp_set_vectors)


-- 
Thanks for your help,
