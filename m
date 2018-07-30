From: cmaiolino28@gmail.com (Carlos Maiolino)
Date: Mon, 30 Jul 2018 11:43:21 +0200
Subject: [PATCH] staging/vc04_services: Use __user annotation for
 user-space pointers
In-Reply-To: <46f35184-fbb5-985c-a5b1-d6ab27ced8bc@i2se.com>
References: <20180724083217.20921-1-cmaiolino28@gmail.com>
 <20180730085811.GA30820@kroah.com>
 <CAGR7KeoDrp8FBX_H1a8h9hVFF_w9mLXGkvCT6jJAacG7-morRg@mail.gmail.com>
 <f6a7405a-4251-c6b8-470f-d50137fb9b00@i2se.com>
 <CAGR7Keo6zD_M+KHMkK8dDm=oujkwxM7Dv7weT11+oKtJNOZpFA@mail.gmail.com>
 <46f35184-fbb5-985c-a5b1-d6ab27ced8bc@i2se.com>
Message-ID: <CAGR7Keqb6B7bYHM7AFm68K7gyBkMXvM2Z=3uvp4HJ7pW-LURSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 11:34 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Carlos,
>
> Am 30.07.2018 um 11:25 schrieb Carlos Maiolino:
>>
>> On Mon, Jul 30, 2018 at 11:13 AM, Stefan Wahren <stefan.wahren@i2se.com>
>> wrote:
>>>
>>> Hi Carlos,
>>>
>>>
>>> Am 30.07.2018 um 11:08 schrieb Carlos Maiolino:
>>>>
>>>> On Mon, Jul 30, 2018 at 10:58 AM, Greg KH <greg@kroah.com> wrote:
>>>>>
>>>>> On Tue, Jul 24, 2018 at 10:32:17AM +0200, Carlos Maiolino wrote:
>>>>>>
>>>>>> Fix several sparse warnings regarding different address space
>>>>>> assignments, like example below, by properly annotating pointers
>>>>>> expected to carry user space addresses.
>>>>>>
>>>>>> warning: incorrect type in argument 1 (different address spaces)
>>>>>> Signed-off-by: Carlos Maiolino <cmaiolino28@gmail.com>
>>>>>> ---
>>>>>
>>>>> We need a blank line befor your signed-off-by line please.
>>>>>
>>>> Thanks, I'll resend, or do you prefer me to way until this get a review
>>>> from
>>>> the maintainer, and I resend the fixed description with the reviewed-by?
>>>
>>>
>>> did you test your patch via vchiq_test or something else?
>>>
>> Hi, no. Can you please point me where I can get it?
>>
>>
>
> i think easiest the way would be to get a recent Raspbian Lite (
> https://www.raspberrypi.org/downloads/raspbian/ ),
> build the kernel with bcm2835_defconfig, modify config.txt to use the
> upstream DTB, add the upstream kernel and DTB to boot partition.
>
> The following command must be successful:
>
> vchiq_test -f 1

K, I'll take a look and find a way to test it, I don't have a rPI at
the moment to test
it, I'll take a look if I can borrow one. in mean time, can it be
tested somehow in x86 environment?
