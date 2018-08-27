From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Aug 2018 00:41:07 +0200
Subject: assembly syntax
In-Reply-To: <CAKwvOdkr4UCvxVYLoCamUkYKj5ZszW=zxrwG243-Jk6P_DKUGQ@mail.gmail.com>
References: <CAKwvOdkr4UCvxVYLoCamUkYKj5ZszW=zxrwG243-Jk6P_DKUGQ@mail.gmail.com>
Message-ID: <CAKv+Gu8ztQ0mhyKJjT4Q2USF6G5VoBco2Ngv=aWz9DqQCEVOiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2018 at 00:33, Nick Desaulniers <ndesaulniers@google.com> wrote:
> Hi Ard,
> Trying to file bugs for clang's integrated assembler, I'm hitting a
> syntax error with clang, but I don't understand how the notation is
> supposed to work.
>
> arch/arm64/kernel/reloc_test_syms.S
> 39: movz x0, #:abs_g3:sym64_abs
>
> arch/arm64/include/asm/assembler.h
> 504: movz \reg, :abs_g3:\val
>
> Clang is not happy with :abs_g3:, but I'm not sure how that code is
> supposed to work? Is it supposed to be a prefix for a relocation?
>
> I *think* R_AARCH64_MOVW_UABS_G3 is somehow related, but I'm
> unfamiliar with this syntax.  Your name was on the `git blame` for
> those lines but I still don't understand, even while looking at
> commit 214fad550772 ("arm64: relocation testing module").
>
> Are there docs you can point me at for this?

As you have guessed, it is used to annotate the instruction with the
correct relocation. You'll have to dig into the binutils sources for
the details, I'm afraid.

But if I may ask, what is the point of using Clang's integrated
assembler? Surely, you don't need it for things like CFI and other
Clang goodies?
