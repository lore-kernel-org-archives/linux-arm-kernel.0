From: david@lechnology.com (David Lechner)
Date: Fri, 20 Jan 2017 12:17:12 -0600
Subject: [PATCH v2 1/2] ARM: davinci: Allocate extra interrupts
In-Reply-To: <0bd745dc-df46-0d37-ed18-b419c1cf2e78@ti.com>
References: <1484337612-11120-1-git-send-email-david@lechnology.com>
 <1484337612-11120-2-git-send-email-david@lechnology.com>
 <95440160-8346-fef8-27d2-fb17c0da38f6@ti.com>
 <25c0bc60-bb99-9aa5-db56-6299d82db9c1@lechnology.com>
 <0bd745dc-df46-0d37-ed18-b419c1cf2e78@ti.com>
Message-ID: <dedc276f-e25b-f3b8-dc4a-568f41d9f82e@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 05:50 AM, Sekhar Nori wrote:
> On Wednesday 18 January 2017 10:27 PM, David Lechner wrote:
>> On 01/18/2017 03:50 AM, Sekhar Nori wrote:
>>> On Saturday 14 January 2017 01:30 AM, David Lechner wrote:
>>>> This allocates extra interrupts for mach-davinci. These extra interrupts
>>>> are need for things like IIO triggers.
>>>
>>> I am not really familiar with IIO triggers. Can you give some more
>>> detail on what fails without this patch?
>>
>> A trigger is used to initiate the reading of an iio device. For example,
>> there is a mechanism for a sysfs trigger. When you write 1 to the sysfs
>> attribute, it triggers an interrupt that is handled by the iio device.
>>
>> Since these triggers use interrupts, you need to allocate spare
>> interrupts in order to set up the trigger. Otherwise, setting up the
>> trigger will fail with an error code (I forgot which one exactly)
>> because all of the allocated irqs have already been assigned to hardware
>> irqs and are not available.
>>
>> Here is where the iio subsytem actually allocates the irq:
>> http://lxr.free-electrons.com/source/drivers/iio/industrialio-trigger.c#L525
>
> Alright, I will take a look. Do note that this may not get included in
> the first batch of v4.11 changes I queue. But I promise to come back to
> it soon afterwards.
>

It is not critical at this point, so it is fine to wait a bit.
