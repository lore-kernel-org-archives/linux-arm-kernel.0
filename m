From: dann.frazier@canonical.com (Dann Frazier)
Date: Thu, 8 Oct 2015 12:44:57 -0700
Subject: [PATCH] arm64: errata: use KBUILD_CFLAGS_MODULE for erratum
 #843419
In-Reply-To: <1444325555-32108-1-git-send-email-will.deacon@arm.com>
References: <1444325555-32108-1-git-send-email-will.deacon@arm.com>
Message-ID: <CALdTtnujU5t6wtk2gyzcVJLn2BrxXJCKT4Sex09ORas52kKA8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 8, 2015 at 10:32 AM, Will Deacon <will.deacon@arm.com> wrote:
> Commit df057cc7b4fa ("arm64: errata: add module build workaround for
> erratum #843419") sets CFLAGS_MODULE to ensure that the large memory
> model is used by the compiler when building kernel modules.
>
> However, CFLAGS_MODULE is an environment variable and intended to be
> overridden on the command line, which appears to be the case with the
> Ubuntu kernel packaging system, so use KBUILD_CFLAGS_MODULE instead.

Oh - didn't notice you'd beat me to it :)

> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: Dann Frazier <dann.frazier@canonical.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

fwiw, I did a full Ubuntu build w/ this and can confirm modules load again.

Tested-by: dann frazier <dann.frazier@canonical.com>

> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index f9914d7c1bb0..d10b5d483022 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -42,7 +42,7 @@ endif
>  CHECKFLAGS     += -D__aarch64__
>
>  ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
> -CFLAGS_MODULE  += -mcmodel=large
> +KBUILD_CFLAGS_MODULE   += -mcmodel=large
>  endif
>
>  # Default value
> --
> 2.1.4
>
