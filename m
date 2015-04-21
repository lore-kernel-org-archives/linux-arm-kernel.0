From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 21 Apr 2015 10:41:15 +0100
Subject: [PATCH v3 3/8] selftests/breakpoints: emit skip and omit
 installation when tests are not compiled
In-Reply-To: <1429571661-26337-1-git-send-email-tyler.baker@linaro.org>
References: <1429571661-26337-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <55361B3B.3060505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/15 00:14, Tyler Baker wrote:
> The breakpoints test should only should be executed on x86 targets, so lets
> emit a skip and omit the installation when ARCH != x86.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>   tools/testing/selftests/breakpoints/Makefile | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
> index 1822356..430b76d 100644
> --- a/tools/testing/selftests/breakpoints/Makefile
> +++ b/tools/testing/selftests/breakpoints/Makefile
> @@ -8,7 +8,6 @@ ifeq ($(ARCH),x86_64)
>   	ARCH := x86
>   endif
>
> -
>   all:
>   ifeq ($(ARCH),x86)
>   	gcc breakpoint_test.c -o breakpoint_test
> @@ -20,5 +19,11 @@ TEST_PROGS := breakpoint_test
>
>   include ../lib.mk
>
> +install:
> +ifneq ($(ARCH),x86)
> +echo "Not an x86 target, can't install breakpoints selftests"
It would make more sense to send this to stderr than stdout, people may 
look for errors there.

Cheers
Suzuki
