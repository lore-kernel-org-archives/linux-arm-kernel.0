From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Jan 2013 10:03:57 -0800
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOesGMhRu14UMafi_q7wmFsZ-m0q-25jDmUKfkNWjztter0Z=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 6:45 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Instead of giving zero support of uncompress debug for multiplatform
> build, the patch turns uncompress debug into one part of DEBUG_LL
> support.  When DEBUG_LL is turned on for a particular platform,
> uncompress debug works too for that platform.
>
> It reuses the platform DEBUG_LL macros by creating a simple
> arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
> included there, and implements a generic putc() using those macros.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

This looks great, and it's even cleaner than I was hoping it'd be
based on my suggestion. Nice! :)

Russell, do you want to apply this or should we? If the former, for
the patch tracker:

Acked-by: Olof Johansson <olof@lixom.net>

If the latter, let me know and I'll pick it up.


Thanks!

-Olof
