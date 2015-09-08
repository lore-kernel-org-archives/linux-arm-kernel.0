From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 8 Sep 2015 23:59:50 +0900
Subject: [PATCH] arm64: kernel: Use a separate stack for irq interrupts.
In-Reply-To: <55EE3DCB.40401@linaro.org>
References: <55EDA040.90208@arm.com>
 <1441636584-23174-1-git-send-email-james.morse@arm.com>
 <400272B6-0733-456F-95C9-9C72C597CEB5@gmail.com> <55EDB5FB.8060800@arm.com>
 <81D7F9F1-1552-4709-BA74-1BF15163C4A0@gmail.com> <55EE3DCB.40401@linaro.org>
Message-ID: <E94EE887-6838-4D08-8684-000A33EBAF61@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 8, 2015, at 10:45 AM, AKASHI Takahiro wrote:
> Jungseok,

Hi Akashi,

> On 09/08/2015 01:34 AM, Jungseok Lee wrote:
>> On Sep 8, 2015, at 1:06 AM, James Morse wrote:
>>> On 07/09/15 16:48, Jungseok Lee wrote:
>>>> On Sep 7, 2015, at 11:36 PM, James Morse wrote:
>>>> 
>>>> Hi James,
>>>> 
>>>>> Having to handle interrupts on top of an existing kernel stack means the
>>>>> kernel stack must be large enough to accomodate both the maximum kernel
>>>>> usage, and the maximum irq handler usage. Switching to a different stack
>>>>> when processing irqs allows us to make the stack size smaller.
>>>>> 
>>>>> Maximum kernel stack usage (running ltp and generating usb+ethernet
>>>>> interrupts) was 7256 bytes. With this patch, the same workload gives
>>>>> a maximum stack usage of 5816 bytes.
>>>> 
>>>> I'd like to know how to measure the max stack depth.
>>>> AFAIK, a stack tracer on ftrace does not work well. Did you dump a stack
>>>> region and find or track down an untouched region?
>>> 
>>> I enabled the 'Trace max stack' option under menuconfig 'Kernel Hacking' ->
>>> 'Tracers', then looked in debugfs:/tracing/stack_max_size.
>>> 
>>> What problems did you encounter?
>>> (I may be missing something?)
>> 
>> When I enabled the feature, all entries had *0* size except the last entry.
>> It can be reproduced easily as looking in debugs:/tracing/stack_trace.
> 
> I'm afraid that you have not applied one of patches in my RFC:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355919.html

My description is not clear. Whenever I use a stack tracer, I always put your
RFC and Steve's stack tracer fix on top of my tree.

Best Regards
Jungseok Lee
