From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Jan 2016 11:16:13 -0800
Subject: [PATCH v3] ARM: fix atags_to_fdt with stack-protector-strong
In-Reply-To: <CAMuHMdV-bHCughvYcVQfCf5wA-eS76LSeX4kPw13FZdvqQk9eg@mail.gmail.com>
References: <20160106233656.GA9316@www.outflux.net>
 <20160107113029.GE19062@n2100.arm.linux.org.uk>
 <CAGXu5jJS1RTpwA9TRCP1y1Qm-g0OXADSb1omr_5rNFirVTovuw@mail.gmail.com>
 <CAMuHMdV-bHCughvYcVQfCf5wA-eS76LSeX4kPw13FZdvqQk9eg@mail.gmail.com>
Message-ID: <CAGXu5jJ_nNwNjRFYDEjp_Q9b+isUmDG0ZFG-Lz7O5i03JP8Y4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 11:11 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Kees,
>
> On Thu, Jan 7, 2016 at 7:40 PM, Kees Cook <keescook@chromium.org> wrote:
>>> Also, I suspect that all of the decompressor should be built with
>>> -fno-stack-protector as we don't have sufficient environment here.
>>> Maybe it should be placed in the global CFLAGS for the decompressor?
>>
>> I prefer keeping it disabled in as narrow a range as possible. If
>> other code gains a level of complexity that it triggers the stack
>> protector code insertion, I think that's worth examining when it
>> happens. If this ever becomes an actual burden, then yeah, let's do it
>> for the whole decompressor, but I think it'd be best to revisit it if
>> it happens again.
>
> What's the failure mode if the stack protector code insertion is triggered?

AIUI, this code shouldn't even link if the ssp code gets inserted
since it can't resolve __stack_chk_fail.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
