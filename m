From: ndesaulniers@google.com (Nick Desaulniers)
Date: Fri, 3 Aug 2018 10:17:57 -0700
Subject: [PATCH] arm64: build CONFIG_ARM64_LSE_ATOMICS without -ffixed-
 flags
In-Reply-To: <CAKv+Gu_QzzDSV74pzLQcPBsWHZK5hvMwa8PojSJmzTOMnY780Q@mail.gmail.com>
References: <20180802231753.86336-1-trong@android.com>
 <CAKv+Gu_QzzDSV74pzLQcPBsWHZK5hvMwa8PojSJmzTOMnY780Q@mail.gmail.com>
Message-ID: <CAKwvOd=vYBoZazvvN=MHVZnYtekgr-fCktuOFePsV-eSvbFQyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 3, 2018 at 1:43 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 3 August 2018 at 01:17, Tri Vo <trong@android.com> wrote:
> > Remove -ffixed- compile flags as they are not required for correct
> > behavior of out-of-line ll/sc implementations of atomic functions.
> > Registers (except x0 which contains return value) only need to be
> > callee-saved, not necessarily fixed.
> >
> > For readability purposes, represent "callee-saves-all-registers" calling
> > convention with a combination of -fcall-used- and -fcall-saved- flags only.
> >
> > Signed-off-by: Tri Vo <trong@android.com>
>
> Wouldn't this permit the compiler to stack/unstack these registers in
> the implementations of the out of line LL/SC fallbacks.

I'm curious to understand more about how this LSE patching works, and
what the constraints exactly are.  Are there some docs I should read
that you can point me to?  I see
arch/arm64/include/asm/atomic_ll_sc.h, but are those are the in line
implementations?  Does that make arch/arm64/include/asm/atomic.h the
out of line definitions?  What are the restrictions around preventing
the compiler to push/pop those registers?

-- 
Thanks,
~Nick Desaulniers
