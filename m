From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 28 Apr 2014 18:58:35 +0900
Subject: [PATCH v5 2/4] arm64: split syscall_trace() into separate
 functions for enter/exit
In-Reply-To: <20140416132716.GA1001@arm.com>
References: <1394705491-12343-1-git-send-email-takahiro.akashi@linaro.org>
 <1394861948-28712-1-git-send-email-takahiro.akashi@linaro.org>
 <1394861948-28712-3-git-send-email-takahiro.akashi@linaro.org>
 <20140416132716.GA1001@arm.com>
Message-ID: <535E264B.7050806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2014 10:27 PM, Will Deacon wrote:
> Hi Akashi,
>
> On Sat, Mar 15, 2014 at 05:39:06AM +0000, AKASHI Takahiro wrote:
>> As done in arm, this change makes it easy to confirm we invoke syscall
>> related hooks, including syscall tracepoint, audit and seccomp which would
>> be implemented later, in correct order. That is, undoing operations in the
>> opposite order on exit that they were done on entry.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> [...]
>
>> +static void tracehook_report_syscall(struct pt_regs *regs,
>> +				     enum ptrace_syscall_dir dir)
>>   {
>> +	int scrach;
>
> s/scrach/scratch/

I will fix it.

> Although, I'd rather have a variable with a more meaningful name. How about
> regno?

OK, I will use regno in the next revision, which I will submit soon.

> With that,
>
>    Acked-by: Will Deacon <will.deacon@arm.com>

Thank you so much,
-Takahiro AKASHI

> Cheers,
>
> Will
>
