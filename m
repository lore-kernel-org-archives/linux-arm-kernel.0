From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 22 Mar 2018 22:26:18 +0000
Subject: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
In-Reply-To: <20180322212705.141175-1-mka@chromium.org>
References: <20180322212705.141175-1-mka@chromium.org>
Message-ID: <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that a patch in this form has previously been implemented by:

Andrey Konovalov <andreyknvl@google.com>:
https://gist.github.com/xairy/ee11682ea86044a45c0291c528cd936f

and another by:

Greg Hackmann <ghackmann@google.com>:
https://android-review.googlesource.com/c/kernel/common/+/645181

If you used either as a reference, you may want to credit them with a
`Suggested-by:` in the commit message.

On Thu, Mar 22, 2018 at 2:28 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> +#ifndef __clang__
> +#define __reg__ "r"
> +#else
> +#define __reg__ "x"
> +#endif

Can this be flipped to #ifdef __clang__ ?  having an if...else where the
conditional negated is kind of funny.

--
Thanks,
~Nick Desaulniers
