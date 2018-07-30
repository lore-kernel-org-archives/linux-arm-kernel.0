From: cmaiolino28@gmail.com (Carlos Maiolino)
Date: Mon, 30 Jul 2018 11:25:54 +0200
Subject: [PATCH] staging/vc04_services: Use __user annotation for
 user-space pointers
In-Reply-To: <f6a7405a-4251-c6b8-470f-d50137fb9b00@i2se.com>
References: <20180724083217.20921-1-cmaiolino28@gmail.com>
 <20180730085811.GA30820@kroah.com>
 <CAGR7KeoDrp8FBX_H1a8h9hVFF_w9mLXGkvCT6jJAacG7-morRg@mail.gmail.com>
 <f6a7405a-4251-c6b8-470f-d50137fb9b00@i2se.com>
Message-ID: <CAGR7Keo6zD_M+KHMkK8dDm=oujkwxM7Dv7weT11+oKtJNOZpFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 11:13 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Carlos,
>
>
> Am 30.07.2018 um 11:08 schrieb Carlos Maiolino:
>>
>> On Mon, Jul 30, 2018 at 10:58 AM, Greg KH <greg@kroah.com> wrote:
>>>
>>> On Tue, Jul 24, 2018 at 10:32:17AM +0200, Carlos Maiolino wrote:
>>>>
>>>> Fix several sparse warnings regarding different address space
>>>> assignments, like example below, by properly annotating pointers
>>>> expected to carry user space addresses.
>>>>
>>>> warning: incorrect type in argument 1 (different address spaces)
>>>> Signed-off-by: Carlos Maiolino <cmaiolino28@gmail.com>
>>>> ---
>>>
>>> We need a blank line befor your signed-off-by line please.
>>>
>> Thanks, I'll resend, or do you prefer me to way until this get a review
>> from
>> the maintainer, and I resend the fixed description with the reviewed-by?
>
>
> did you test your patch via vchiq_test or something else?
>

Hi, no. Can you please point me where I can get it?


> Please add Eric Anholt

Sure, will do

>and fix my mail address in the second version, i only
> received this via mailing list.
>

Meh, I shall use copy/paste next time :P
> Stefan
>
>>
>>
>>>> +     const struct vchiq_element __user *elements;
>>>>   } VCHIQ_QUEUE_MESSAGE_T;
>>>>
>>>>   typedef struct {
>>>
>>> It would be great to have an ack from the maintainers here :)
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> _______________________________________________
>> linux-rpi-kernel mailing list
>> linux-rpi-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
>
>
