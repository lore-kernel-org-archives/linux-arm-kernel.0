From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 10 Jan 2012 18:34:27 +0530
Subject: BUG: sleeping function called from invalid context at
 include/linux/freezer.h:45
In-Reply-To: <CAH9JG2XniMv5dVf1DixGNaQAJk-sZjnV9HfYeihEJP3JDyC4+Q@mail.gmail.com>
References: <CAH9JG2XniMv5dVf1DixGNaQAJk-sZjnV9HfYeihEJP3JDyC4+Q@mail.gmail.com>
Message-ID: <4F0C375B.7040600@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2012 09:57 AM, Kyungmin Park wrote:

> Dear all
> 
> with the latest kernel. I got the below bug message.
> It calls the sleep function. Does it intended operation?
> 
> static inline bool try_to_freeze(void)
> {
>         might_sleep();
>         if (likely(!freezing(current)))
>                 return false;
>         return __refrigerator(false);
> }
> 
> # poweroff
> [    6.852523] BUG: sleeping function called from invalid context at
> include/linux/freezer.h:45
> [    6.859489] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
> [    6.865846] [<c0013508>] (unwind_backtrace+0x0/0xec) from
> [<c0010124>] (do_signal+0x88/0x588)
> [    6.874337] [<c0010124>] (do_signal+0x88/0x588) from [<c001063c>]
> (do_notify_resume+0x18/0x38)
> [    6.882928] [<c001063c>] (do_notify_resume+0x18/0x38) from
> [<c000dc18>] (work_pending+0x24/0x28)
> 


You seem to be running on Arm architecture. Can you please try the patch
at https://lkml.org/lkml/2011/8/25/231 ?

Regards,
Srivatsa S. Bhat
IBM Linux Technology Center
