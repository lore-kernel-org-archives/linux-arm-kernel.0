From: ndesaulniers@google.com (Nick Desaulniers)
Date: Mon, 27 Aug 2018 15:33:57 -0700
Subject: assembly syntax
Message-ID: <CAKwvOdkr4UCvxVYLoCamUkYKj5ZszW=zxrwG243-Jk6P_DKUGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,
Trying to file bugs for clang's integrated assembler, I'm hitting a
syntax error with clang, but I don't understand how the notation is
supposed to work.

arch/arm64/kernel/reloc_test_syms.S
39: movz x0, #:abs_g3:sym64_abs

arch/arm64/include/asm/assembler.h
504: movz \reg, :abs_g3:\val

Clang is not happy with :abs_g3:, but I'm not sure how that code is
supposed to work? Is it supposed to be a prefix for a relocation?

I *think* R_AARCH64_MOVW_UABS_G3 is somehow related, but I'm
unfamiliar with this syntax.  Your name was on the `git blame` for
those lines but I still don't understand, even while looking at
commit 214fad550772 ("arm64: relocation testing module").

Are there docs you can point me at for this?
-- 
Thanks,
~Nick Desaulniers
