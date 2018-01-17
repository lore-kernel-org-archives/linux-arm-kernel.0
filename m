From: keescook@chromium.org (Kees Cook)
Date: Wed, 17 Jan 2018 12:45:39 -0800
Subject: per-task stack canaries for arm64
In-Reply-To: <CAKv+Gu9vViZUBYJWnGdnewL9h-ahP0Hs8gU+3_QH76ROdQh1yQ@mail.gmail.com>
References: <CAKv+Gu_rdDEQeBYabZCOywws96mTWF4F=JEpVNXEW76tAwo1Rw@mail.gmail.com>
 <CAGXu5j+cJoc6o8d-hmLFj08r18GhEbKhVNA94LDKM5yqo9CbSQ@mail.gmail.com>
 <CAKv+Gu9vViZUBYJWnGdnewL9h-ahP0Hs8gU+3_QH76ROdQh1yQ@mail.gmail.com>
Message-ID: <CAGXu5j+PO=Ben0J-xnOztrAdsku2SUKFiz6w7cqTEfHTveFFSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 12:32 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 17 January 2018 at 19:10, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Jan 17, 2018 at 10:24 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
> [...]
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
>> which was done for x86 only, and provides both:
>>   -mstack-protector-guard-symbol=...
>>   -mstack-protector-guard-reg=...
>>
>> If this could be extended to arm64, I think we'd be in good shape (and
>> it could be trivially detected at build time).
>>
>
> I'm not entirely sure what the point is of specifying the name of the
> symbol on the command line. It is ultimately up to the GCC developers
> to decide how much point there is to maintaining parity with x86 here.
>
> [...]
>>> Ramana indicated at the time that he would be up for adding, e.g.,
>>> -fstack-protector-linux-kernel as a command line option, and add the
>>> contents of tpidr_el1 to every reference of __stack_chk_guard when
>>> set.
>>
>> I think we want to reuse the command-line names from the x86 options
>> above, unless there's a good reason not to?
>
> I'm perfectly happy to settle for whatever the GCC developers manage
> to agree on, as long as it gives us the ability to use tpidr_el1 as
> the offset.

Ramana, Uro?, what's the best next step? Should we open a GCC bug
specifically for arm64 here?

-Kees

-- 
Kees Cook
Pixel Security
