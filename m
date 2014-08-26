From: jcm@redhat.com (Jon Masters)
Date: Tue, 26 Aug 2014 16:52:07 -0400
Subject: [PATCH] setup: Move unmask of async interrupts after possible
 earlycon setup
In-Reply-To: <CACxGe6spd4Oesv-+2PdWkNXESk66ObXWCyDqWmQ4o5aEXanqZA@mail.gmail.com>
References: <1409079338-14001-1-git-send-email-jcm@redhat.com>
 <CACxGe6s_s=oufaEaaN6Hgz9rUzuGDX-c0RG_-JtYSP598FOeCw@mail.gmail.com>
 <53FCE87C.6030201@redhat.com>
 <CACxGe6spd4Oesv-+2PdWkNXESk66ObXWCyDqWmQ4o5aEXanqZA@mail.gmail.com>
Message-ID: <53FCF377.8050705@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2014 04:09 PM, Grant Likely wrote:
> On Tue, Aug 26, 2014 at 9:05 PM, Jon Masters <jcm@redhat.com> wrote:
>> Hi Grant,
>>
>> On 08/26/2014 04:01 PM, Grant Likely wrote:
>>> On Tue, Aug 26, 2014 at 7:55 PM, Jon Masters <jcm@redhat.com> wrote:
>>>> The kernel wants to enable reporting of asynchronous interrupts (i.e.
>>>> System Errors) as early as possible. But if this happens too early
>>>> then a pending System Error on initial entry into the kernel will
>>>> never be reported where a user can see it (instead it will remain
>>>> in the kernel ring buffer and be visible only via hardware debug).
>>>> Therefore, move the enabling of asynchronous interrupts to after
>>>> parsing any possible earlycon parameters setting up earlycon.
>>>>
>>>> Signed-off-by: Jon Masters <jcm@redhat.com>
>>>
>>> That sounds wrong. Why aren't early log messages getting flushed out
>>> when the console shows up?
>>
>> The problem is that when such an error occurs, we immediately panic. And
>> we've not setup the earlycon yet so there's no way to ever see it. I
>> wasted a bunch of time last week so it's worth saving someone else.
> 
> Reasonable reason. Perhaps put that in the patch description.

Sent a V2 with that fixed. Forgot to copy you, apologies.

Jon.
