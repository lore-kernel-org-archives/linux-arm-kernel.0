From: keescook@chromium.org (Kees Cook)
Date: Wed, 16 Jul 2014 14:57:20 -0700
Subject: [PATCH 5/7] x86: Split syscall_trace_enter into two phases
In-Reply-To: <CALCETrWuWxZANoKAR=FG55EOHtzvTHmc3euMdtf8yfibtK-QYw@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net>
 <bd4e2efb7cd97f2bf9d4f1e2065f16c9091d799a.1405452484.git.luto@amacapital.net>
 <CAGXu5jJornzMJjyPXVZB_eYi-FRet=bXcJWJDa1vnB_oU9ZA_Q@mail.gmail.com>
 <CALCETrWuWxZANoKAR=FG55EOHtzvTHmc3euMdtf8yfibtK-QYw@mail.gmail.com>
Message-ID: <CAGXu5jLcbWDJiLbpejJTERbV2CkCk2dVZ7jwq7Xw_jYUicBFjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 2:15 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jul 16, 2014 at 1:21 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>
>>> +
>>> +               ret = seccomp_phase1(&sd);
>>> +               if (ret == SECCOMP_PHASE1_SKIP) {
>>> +                       regs->orig_ax = -ENOSYS;
>>
>> Before, seccomp didn't touch orig_ax on a skip. I don't see any
>> problem with this, and it's probably more clear this way, but are you
>> sure there aren't unexpected side-effects from this?
>
> It's necessary to cause the syscall to be skipped -- see syscall_trace_enter.
>
> That being said, setting it to -ENOSYS is nonsense and probably
> confused you at least as much as it confused me.  It should be
> regs->orig_ax = -1.

Yes, I think that would be better.

-Kees

-- 
Kees Cook
Chrome OS Security
