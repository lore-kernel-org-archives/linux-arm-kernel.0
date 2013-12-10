From: anurag19aggarwal@gmail.com (Anurag Aggarwal)
Date: Tue, 10 Dec 2013 21:49:51 +0530
Subject: [PATCH V6] ARM : unwinder : Prevent data abort due to stack
 overflow
In-Reply-To: <16479184.50751386647682015.JavaMail.weblogic@epv6ml09>
References: <16479184.50751386647682015.JavaMail.weblogic@epv6ml09>
Message-ID: <CAPoNrttdDbwstOMa8s23oLmzOc2KcJztfgmVB0A8mCWWR0DZZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>+               if (*vsp >= (unsigned long *)ctrl->sp_high)
>>+                       return -URC_FAILURE;

I tested the same patch, by adding a printk statement in the above if condition.
The print statement I added came a few times as a part of dmesg log.

I think this proves that such corner cases are being handled by the above code

Regards
Anurag

On Tue, Dec 10, 2013 at 9:24 AM, Anurag Aggarwal <a.anurag@samsung.com> wrote:
>>Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>>
>>I can confirm that the kernel "doesn't crash" with this applied, and
>>that backtracing at least partially works.  But this is not really
>>sufficient to demontrate that the now code works better than the old
>>code in corner cases (which is the point of the patch).
>>
>>Can you give details of what additional testing you have, or plan to
>>do?
>
> We saw a data abort in unwinder for one of Samsung Project, during a
> Samsung Automation test case.
> After that I created the initial the patch, and the data abort has not been
> seen till now.
>
> Is it possible for you to give an idea on what other kind of additional testing
> do you have in mind.
>
> Regads
> Anurag
>



-- 
Anurag Aggarwal
