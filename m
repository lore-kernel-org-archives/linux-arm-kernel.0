From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 28 Oct 2013 13:44:30 +1030
Subject: [RFC PATCH] kernel/kallsyms.c: only show legal kernel symbol
In-Reply-To: <CACVXFVN7PiU1dorkeamtC9-Wg_TVQE8xFiJtad-C8q4_=Rc1Ow@mail.gmail.com>
References: <1382498320-26594-1-git-send-email-tom.leiming@gmail.com>
 <87eh7bfoq9.fsf@rustcorp.com.au>
 <20131024084559.GD16735@n2100.arm.linux.org.uk>
 <87mwlyclng.fsf@rustcorp.com.au>
 <CACVXFVO86u0h0V-1_DCkO5HNyUp2i_UsjPrVWDb-ZBtmwVk28A@mail.gmail.com>
 <87y55h7vcd.fsf@rustcorp.com.au>
 <CACVXFVPXEUX9JQ2NZvL8=J34zbw2fn202QW2SQtpKjdQ+tv=vg@mail.gmail.com>
 <87sivp7eai.fsf@rustcorp.com.au>
 <CACVXFVN7PiU1dorkeamtC9-Wg_TVQE8xFiJtad-C8q4_=Rc1Ow@mail.gmail.com>
Message-ID: <874n82gk89.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:
> On Fri, Oct 25, 2013 at 7:58 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>>
>>> Basically these symbols are only used to generate code, and in
>>> kernel mode, CPU won't run into the corresponding addresses
>>> because the generate code is copied to other address during booting,
>>> so I understand they won't appear in backtraces.
>>
>> An oops occurs when something went *wrong*.  We look up all kinds of
>> stuff.  Are you so sure that *none* of the callers will ever see these
>> strange symbols and produce a confusing result?
>
> Suppose that might happen, kernel should be smart enough to know
> that the address is not inside kernel address space and won't produce
> confusing result, right?

I don't know...  It would be your job, as the person making the change,
to find all the users of kallsyms and prove that.

This is why it is easier not to include incorrect values in the kernel's
kallsyms in the first place.

Hope that helps,
Rusty.
