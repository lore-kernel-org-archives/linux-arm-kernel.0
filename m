From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Sep 2018 16:58:29 +0100
Subject: [RFC] arm64: lse: remove -fcall-used-x0 flag
In-Reply-To: <20180919192750.200491-1-trong@android.com>
References: <20180919192750.200491-1-trong@android.com>
Message-ID: <20180921155829.GD1451@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 12:27:50PM -0700, Tri Vo wrote:
> x0 is not callee-saved in the PCS. So there is no need to specify
> -fcall-used-x0.
> 
> Clang doesn't currently support -fcall-used flags. This patch will help
> building the kernel with clang.
> 
> Signed-off-by: Tri Vo <trong@android.com>
> ---
>  arch/arm64/lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If this is useful to you, then:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index c86b7909ef31..2f7c60c8e588 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -11,7 +11,7 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
>  # when supported by the CPU. Result and argument registers are handled
>  # correctly, based on the function prototype.
>  lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
> -CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
> +CFLAGS_atomic_ll_sc.o	:= -ffixed-x1 -ffixed-x2        		\
>  		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
>  		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
>  		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
> --
> 2.19.0.397.gdd90340f6a-goog
> 
