From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Tue, 21 Aug 2012 07:29:52 -0700
Subject: [PATCH v3] ARM: support syscall tracing
In-Reply-To: <20120821082734.GA28660@mudshark.cambridge.arm.com>
References: <50324BED.9000500@mentor.com>
 <20120820172559.GW25864@mudshark.cambridge.arm.com>
 <5032A1D6.6010605@mentor.com>
 <20120821082734.GA28660@mudshark.cambridge.arm.com>
Message-ID: <50339B60.7030909@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> On Mon, Aug 20, 2012 at 09:45:10PM +0100, Wade Farnsworth wrote:
>> Will Deacon wrote:
>>>
>>> I think that trace_sys_{enter,exit} should take ret rather than scno. A
>>> debugger could change the syscall number if TIF_SYSCALL_TRACE is set and
>>> that new number should be the one that we use.
>>>
>>> The style, however, is much better and I think the code is fairly clear now
>>> so we just need to wait for my fix to the core code to get merged (it got
>>> picked up by Steve Rostedt) and I think we can use ret directly. It might be
>>> worth dropping the local variable and using scno for everything, so that
>>> it's obvious where the syscall number is stored.
>>>
>>
>> I agree that your patch needs to get merged before mine gets picked up
>> so that we don't introduce a new bug.  I've sent v4 with the changes you
>> suggest.  Would you like me to modify syscall_trace_* to remove the
>> local variable in this patch as well?  It seems to me that such a rework
>> is better handled separately, but let me know if you think otherwise.
>
> Don't worry about the scno rework -- I'll do that as a separate patch
> because I think that the audit calls need updating to use the return value
> from ptrace_syscall_trace too (otherwise you could use a debugger to execute
> syscalls that you shouldn't be allowed to make).
>
> So, if it's ok with you, I'll take this into my tree and then send it to
> Russell along with the scno change once the core fix has been merged into
> mainline.

Sounds great.  Thanks, Will!

Wade
