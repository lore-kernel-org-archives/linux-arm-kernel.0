From: keescook@chromium.org (Kees Cook)
Date: Fri, 19 May 2017 14:32:22 -0700
Subject: stackprotector: ascii armor the stack canary
In-Reply-To: <20170519212636.30440-1-riel@redhat.com>
References: <20170519212636.30440-1-riel@redhat.com>
Message-ID: <CAGXu5jJ9O=ZOjbqp6M3xBZUnUwNqJENtxMHOcZta3eAq02e54Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 2:26 PM,  <riel@redhat.com> wrote:
> Zero out the first byte of the stack canary value on 64 bit systems,
> in order to prevent unterminated C string overflows from being able
> to successfully overwrite the canary, even if an attacker somehow
> guessed or obtained the canary value.

This also stops string functions from being able to read the canary.

It might also be worth mentioning that the reduction in entropy for
64-bit to gain this corner-case protection is worth it, but on 32-bit,
it is not. (Which is especially true given that the 64-bit canary was
only 32-bits in some cases until recently.)

> Inspired by execshield ascii-armor and PaX/grsecurity.
>
> Thanks to Daniel Micay for extracting code of similar functionality
> from PaX/grsecurity and making it easy to find in his linux-hardened
> git tree on https://github.com/thestinger/linux-hardened/

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
