From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 10 Dec 2015 14:04:41 +0800
Subject: [PATCH] arm64: annotate irq off before schedule
In-Reply-To: <20151209105501.GC26759@e104818-lin.cambridge.arm.com>
References: <1449645829-1070-1-git-send-email-ming.lei@canonical.com>
 <20151209105501.GC26759@e104818-lin.cambridge.arm.com>
Message-ID: <CACVXFVOg5Gr9=EKtZq8306Q7G4oKqsNBV8Gdqaoi1C8DCCgucQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2015 at 6:55 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Dec 09, 2015 at 03:23:49PM +0800, Ming Lei wrote:
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 7ed3d75..4769190 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -634,6 +634,9 @@ work_pending:
>>       bl      do_notify_resume
>>       b       ret_to_user
>>  work_resched:
>> +#ifdef CONFIG_TRACE_IRQFLAGS
>> +     bl      trace_hardirqs_off
>> +#endif
>>       bl      schedule
>
> I think Will already queued a similar patch, though he hasn't pushed it
> out yet.

I tested the misc-patches branch of Will's tree on kerne.org, and looks
the locpdep warning still can be observed.

Thanks,

>
> --
> Catalin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
