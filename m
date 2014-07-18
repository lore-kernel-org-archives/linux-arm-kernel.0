From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 18 Jul 2014 15:26:13 -0700
Subject: [PATCH v2 3/7] seccomp: Allow arch code to provide seccomp_data
In-Reply-To: <CAGXu5jLsnSujJdZmA=nzHw1_K3eYhSiUEnntJ3S2hCZ8DFVYpg@mail.gmail.com>
References: <cover.1405717901.git.luto@amacapital.net>
 <ce65e0e8be18ae8fab437899db44ca41c912b506.1405717901.git.luto@amacapital.net>
 <CAGXu5jLsnSujJdZmA=nzHw1_K3eYhSiUEnntJ3S2hCZ8DFVYpg@mail.gmail.com>
Message-ID: <CALCETrX=hN1yKh=cfcOHffMprjP74PdeRfhTFOYCK7oPhURV_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 3:16 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jul 18, 2014 at 2:18 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> populate_seccomp_data is expensive: it works by inspecting
>> task_pt_regs and various other bits to piece together all the
>> information, and it's does so in multiple partially redundant steps.
>>
>> Arch-specific code in the syscall entry path can do much better.
>>
>> Admittedly this adds a bit of additional room for error, but the
>> speedup should be worth it.
>
> I still think we should gain either a note in the
> HAVE_ARCH_SECCOMP_FILTER help text in arch/Kconfig, or possibly a new
> section in Documentation/prctl/seccomp.txt (or similar) on how do
> implement filter support for an architecture, that mentions the
> arch-supplied seccomp_data and how two-phase can be done.

I would have sworn I did that.  I distinctly remember typing that
text.  I must have failed to commit it.

I'll send a followup patch.

--Andy

>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Andy Lutomirski
AMA Capital Management, LLC
