From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 17 Apr 2015 15:06:54 -0700
Subject: [PATCH v2 5/8] selftest/x86: build both bitnesses
In-Reply-To: <1429308096-4667-1-git-send-email-tyler.baker@linaro.org>
References: <1429308096-4667-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <CALCETrVJr3Lx-Z=_N8BwCC8Ef3bT-mWSSVWGbFg3YSr0ApqC_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 3:01 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
> Using uname with the processor flag option in some cases can yield 'unknown'
> so lets use the machine flag option as it is deterministic. Add a dependency
> for all_32 when building on a x86 64 bit host so that both bitnesses are
> built in this case.
>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  tools/testing/selftests/x86/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index f0a7918..57090ad 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -7,14 +7,14 @@ BINARIES_64 := $(TARGETS_C_BOTHBITS:%=%_64)
>
>  CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
>
> -UNAME_P := $(shell uname -p)
> +UNAME_M := $(shell uname -m)
>
>  # Always build 32-bit tests
>  all: all_32
>
>  # If we're on a 64-bit host, build 64-bit tests as well
> -ifeq ($(shell uname -p),x86_64)
> -all: all_64
> +ifeq ($(UNAME_M),x86_64)
> +all: all_32 all_64

This duplicates the all: all_32 above.

--Andy

>  endif
>
>  all_32: check_build32 $(BINARIES_32)
> --
> 2.1.4
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
