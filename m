From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 26 May 2015 22:02:46 +0900
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <F68D2983-226C-4704-A1E0-E79C9425B822@foss.arm.com>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <5992243.NYDGjLH37z@wuerfel> <B873B881-4972-4524-B1D9-4BB05D7248A4@gmail.com>
 <F68D2983-226C-4704-A1E0-E79C9425B822@foss.arm.com>
Message-ID: <E71E3520-FCE5-4DAE-969D-F59F6A331611@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 26, 2015, at 1:47 AM, Catalin Marinas wrote:
> On 25 May 2015, at 13:01, Jungseok Lee <jungseoklee85@gmail.com> wrote:
> 
>>> Could the stack size be reduced to 8KB perhaps?
>> 
>> I guess probably not.
>> 
>> A commit, 845ad05e, says that 8KB is not enough to cover SpecWeb benchmark.
> 
> We could go back to 8KB stacks if we implement support for separate IRQ 
> stack on arm64. It's not too complicated, we would have to use SP0 for (kernel) threads 
> and SP1 for IRQ handlers.

Definitely interesting.

It looks like there are two options based on discussion.
1) Reduce the stack size with separate IRQ stack scheme
2) Figure out a generic anti-fragmentation solution

Do I miss anything?

I am still not sure about the first scheme as reviewing Minchan's findings repeatedly,
but I agree that the item should be worked actively.

Best Regards
Jungseok Lee
