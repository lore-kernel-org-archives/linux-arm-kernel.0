From: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 25 Oct 2013 16:20:10 +1030
Subject: [RFC PATCH] kernel/kallsyms.c: only show legal kernel symbol
In-Reply-To: <CACVXFVO86u0h0V-1_DCkO5HNyUp2i_UsjPrVWDb-ZBtmwVk28A@mail.gmail.com>
References: <1382498320-26594-1-git-send-email-tom.leiming@gmail.com>
 <87eh7bfoq9.fsf@rustcorp.com.au>
 <20131024084559.GD16735@n2100.arm.linux.org.uk>
 <87mwlyclng.fsf@rustcorp.com.au>
 <CACVXFVO86u0h0V-1_DCkO5HNyUp2i_UsjPrVWDb-ZBtmwVk28A@mail.gmail.com>
Message-ID: <87y55h7vcd.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:
> On Fri, Oct 25, 2013 at 7:08 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>
>> Sorry, I was imprecise.  I was referring to the kernel's kallsyms
>> tables produced by scripts/kallsyms.c.  This patch left them in the
>> the kallsyms tables and filtered them out from /proc/kallsyms.
>
> Yes, but it isn't easy to do it by script/kallsyms.c , and IMO, it should
> be correct to hide them for user space but keep them in kallsyms table.

So they'll appear in backtraces?  And turn up randomly for other symbol
dereferences?

I don't think you really want this!

>> It's weird that cpu_v7_suspend_size appeared above, since kallsyms
>> should filter out 'A' symbols already.
>
> Sorry, the 'A' symbol is a mistake, but the others do exist in /proc/kallsyms.

Ah, OK.

Cheers,
Rusty.
