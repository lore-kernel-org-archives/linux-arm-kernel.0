From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 15 Jan 2014 18:27:49 +0800
Subject: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
In-Reply-To: <20140115100904.GX31570@twins.programming.kicks-ass.net>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
 <CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
 <20140113120435.GQ31570@twins.programming.kicks-ass.net>
 <CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
 <20140115100904.GX31570@twins.programming.kicks-ass.net>
Message-ID: <CAA+hA=R=rYe=y0AFw1SBAA8CgSfiio=J3qWBUmwputC681FakA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 6:09 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jan 15, 2014 at 03:19:27PM +0800, Dong Aisheng wrote:
>> On Mon, Jan 13, 2014 at 8:04 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Thu, Dec 26, 2013 at 03:58:20PM +0800, Dong Aisheng wrote:
>> >> > It's strange that this issue did not happen on kernel 3.10.17 with the same
>> >> > code. And looking at the code, before call spin_lock we already disable the mmc
>> >> > controller irq, per on my understanding, the deadlock given by lockdep may not
>> >> > be able to happen(pls fix me if wrong).
>> >> > May the lockdep not track the specific irq disable?
>> >> > Copy lockdep guy to comment.
>> >
>> > No, lockdep also doesn't know only that one line can take this lock.
>> > Lockdep only knows a lock is taken from IRQ context, and disabling one
>> > line still allows IRQs to happen and therefore it yells.
>>
>> Okay, thanks for the information.
>> If that, kernel 3.10.17 has the same code, do you know why it does not trigger
>> such lockdep error?
>
> No idea; there haven't really been big lockdep changes recently.

Okay, thanks.
Anyway, this patch fix should be needed to avoid the lockdep error.

Chirs,
Can you pick it up?

Regards
Dong Aisheng
