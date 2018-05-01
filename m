From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 01 May 2018 11:43:19 +0100
Subject: [PATCH v3 01/12] ACPI / APEI: Move the estatus queue code up,
 and under its own ifdef
In-Reply-To: <20180427153510.5799-2-james.morse@arm.com> (James Morse's
 message of "Fri, 27 Apr 2018 16:34:59 +0100")
References: <20180427153510.5799-1-james.morse@arm.com>
 <20180427153510.5799-2-james.morse@arm.com>
Message-ID: <877eonr708.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

James Morse <james.morse@arm.com> writes:

> To support asynchronous NMI-like notifications on arm64 we need to use
> the estatus-queue. These patches refactor it to allow multiple APEI
> notification types to use it.
>
> First we move the estatus-queue code higher in the file so that any
> notify_foo() handler can make use of it.
>
> This patch moves code around ... and makes the following trivial change:
> Freshen the dated comment above ghes_estatus_llist. printk() is no
> longer the issue, its the helpers like memory_failure_queue() that
> still aren't nmi safe.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
>


> Notes for cover letter:
> ghes.c has three things all called 'estatus'. One is a pool of memory
> that has a static size, and is grown/shrunk when new NMI users are
> allocated.
> The second is the cache, this holds recent notifications so we can
> suppress notifications we've already handled.
> The last is the queue, which hold data from NMI notifications (in pool
> memory) that can't be handled immediatly.


I am guessing you intended to drop the notes before sending the patch
out.

Calling this out as it'd make sense to clean-this up if the series is
ready for merging.

Thanks,
Punit

[...]
