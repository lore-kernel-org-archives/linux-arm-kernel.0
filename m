From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 4 Nov 2015 17:01:58 +0900
Subject: [PATCH v4 6/6] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <9BDC406F-52E1-4F8C-8245-7B49EC4C861D@gmail.com>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
 <1446182741-31019-7-git-send-email-takahiro.akashi@linaro.org>
 <9BDC406F-52E1-4F8C-8245-7B49EC4C861D@gmail.com>
Message-ID: <5639BB76.6060903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jungseok,

On 11/01/2015 05:30 PM, Jungseok Lee wrote:
> On Oct 30, 2015, at 2:25 PM, AKASHI Takahiro wrote:
>
> Hi Akashi,
>
>> Stack tracer on arm64, check_stack(), is uniqeue in the following
>> points:
>> * analyze a function prologue of a traced function to estimate a more
>>   accurate stack pointer value, replacing naive '<child's fp> + 0x10.'
>> * use walk_stackframe(), instead of slurping stack contents as orignal
>>   check_stack() does, to identify a stack frame and a stack index (height)
>>   for every callsite.
>>
>> Regarding a function prologue analyzer, there is no guarantee that we can
>> handle all the possible patterns of function prologue as gcc does not use
>> any fixed templates to generate them. 'Instruction scheduling' is another
>> issue here.
>> Nevertheless, the current version will surely cover almost all the cases
>> in the kernel image and give us useful information on stack pointers.
>
> Can I get an idea on how to test the function prologue analyzer? It pretty
> tough to compare stack trace data with objdump one. Is there an easier way
> to observe this enhancement without objdump?

It is quite difficult to give an evidence of the correctness of my function
prologue analyzer. I only checked the outputs from stack tracer, one by one
(every function), by comparing it against its disassembled code.

Thanks,
-Takahiro AKASHI

> Best Regards
> Jungseok Lee
>
