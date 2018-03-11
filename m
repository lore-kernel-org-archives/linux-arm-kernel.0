From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 11 Mar 2018 13:20:24 -0700
Subject: [PATCH v8 1/6] arch: enable relative relocations for arm64, power
 and x86
In-Reply-To: <20180311123815.17916-2-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-2-ard.biesheuvel@linaro.org>
Message-ID: <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2018 at 5:38 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Before updating certain subsystems to use place relative 32-bit
> relocations in special sections, to save space and reduce the
> number of absolute relocations that need to be processed at runtime
> by relocatable kernels, introduce the Kconfig symbol and define it
> for some architectures that should be able to support and benefit
> from it.

Are there actually architectures hat _don't_ support those relative
32-bit relocations? That really feels pretty fundamental.

I would have expected all of them to do it - is your selection of
arm64/powerpc/x86 perhaps more about "I have tested these" than about
anything else?

Because I'd almost prefer to just do the switch-over unconditionally
if that is at all possible?

             Linus
