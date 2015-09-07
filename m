From: james.morse@arm.com (James Morse)
Date: Mon, 07 Sep 2015 17:06:19 +0100
Subject: [PATCH] arm64: kernel: Use a separate stack for irq interrupts.
In-Reply-To: <400272B6-0733-456F-95C9-9C72C597CEB5@gmail.com>
References: <55EDA040.90208@arm.com>
 <1441636584-23174-1-git-send-email-james.morse@arm.com>
 <400272B6-0733-456F-95C9-9C72C597CEB5@gmail.com>
Message-ID: <55EDB5FB.8060800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/15 16:48, Jungseok Lee wrote:
> On Sep 7, 2015, at 11:36 PM, James Morse wrote:
> 
> Hi James,
> 
>> Having to handle interrupts on top of an existing kernel stack means the
>> kernel stack must be large enough to accomodate both the maximum kernel
>> usage, and the maximum irq handler usage. Switching to a different stack
>> when processing irqs allows us to make the stack size smaller.
>>
>> Maximum kernel stack usage (running ltp and generating usb+ethernet
>> interrupts) was 7256 bytes. With this patch, the same workload gives
>> a maximum stack usage of 5816 bytes.
> 
> I'd like to know how to measure the max stack depth.
> AFAIK, a stack tracer on ftrace does not work well. Did you dump a stack
> region and find or track down an untouched region? 

I enabled the 'Trace max stack' option under menuconfig 'Kernel Hacking' ->
'Tracers', then looked in debugfs:/tracing/stack_max_size.

What problems did you encounter?
(I may be missing something...)


Thanks,

James
