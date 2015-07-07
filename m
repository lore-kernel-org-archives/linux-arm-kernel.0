From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 7 Jul 2015 22:49:55 +0900
Subject: Stack trace using ftrace
In-Reply-To: <559B86CA.2060508@linaro.org>
References: <5580ED65-69A0-40F9-9626-31A0D066C507@gmail.com>
 <559A34B9.2020605@linaro.org>
 <42A36D72-9621-4FEF-B977-7FC6E4421618@gmail.com>
 <559B86CA.2060508@linaro.org>
Message-ID: <6A4AA92F-8939-428C-8BAD-A1E6529F987C@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 7, 2015, at 4:59 PM, AKASHI Takahiro wrote:
> On 07/06/2015 09:04 PM, Jungseok Lee wrote:
>> On Jul 6, 2015, at 4:56 PM, AKASHI Takahiro wrote:
>>> Hi,
>> 
>> Hi,
>> 
>>> Thank you for your bug report.
>> 
>> Thanks for taking care about this topic.
>> 
>>> This issue comes from the fact that ftrace, more specifically check_stack(),
>>> goes over immediate values in the stack with each function's (bl instruction's) PC
>>> which is returned by save_stack_trace() while save_stack_trace(), or unwind_frame(),
>>> decrements the saved value of PC in the stack by 4. So mismatching can happen.
>>> 
>>> We can easily fix the problem by reverting the following commit:
>>> 
>>>> commit e306dfd06fcb44d21c80acb8e5a88d55f3d1cf63
>>>> Author: Olof Johansson <olof@lixom.net>
>>>> Date:   Fri Feb 14 19:35:15 2014 +0000
>>>> 
>>>>     ARM64: unwind: Fix PC calculation
>>> 
>>> But it will also resurrect the original problem.
>> 
>> IMHO, a current problem cannot be resolved by reverting the commit.
>> Please refer to the following data. The result looks much better than before,
>> but some entries still have 0 sizes.
> 
> Sorry for that.

It's okay.

> There seem to be several problems.
> The value in 'size' field should go one line up,
> for example, 32 for arch_timer_handler and 64 for
> handle_percpu_devid_irq.
> 
> I'm now looking into those issues.

I can support a test with dragonboard410c. Please let me know if necessary.
Thanks again!

Best Regards
Jungseok Lee
