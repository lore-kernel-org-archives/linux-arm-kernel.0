From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 24 May 2017 13:57:52 +0200
Subject: stackprotector: ascii armor the stack canary
In-Reply-To: <CAGXu5jJ9O=ZOjbqp6M3xBZUnUwNqJENtxMHOcZta3eAq02e54Q@mail.gmail.com>
References: <20170519212636.30440-1-riel@redhat.com>
 <CAGXu5jJ9O=ZOjbqp6M3xBZUnUwNqJENtxMHOcZta3eAq02e54Q@mail.gmail.com>
Message-ID: <CAMuHMdXEVLcn3=76H5zk9LNOPZLfV1XfuQ1EtrNjoZ3J3i2Nyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 11:32 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, May 19, 2017 at 2:26 PM,  <riel@redhat.com> wrote:
>> Zero out the first byte of the stack canary value on 64 bit systems,
>> in order to prevent unterminated C string overflows from being able
>> to successfully overwrite the canary, even if an attacker somehow
>> guessed or obtained the canary value.
>
> This also stops string functions from being able to read the canary.
>
> It might also be worth mentioning that the reduction in entropy for
> 64-bit to gain this corner-case protection is worth it, but on 32-bit,
> it is not. (Which is especially true given that the 64-bit canary was
> only 32-bits in some cases until recently.)

+1

It took me a while to deduce that myself, when I started wondering why
this was not done for 32-bit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
