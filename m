From: nori.sekhar@gmail.com (Sekhar Nori)
Date: Mon, 17 Dec 2012 21:01:17 +0530
Subject: [PATCH] ARM: davinci: fix build break due to missing include
In-Reply-To: <1355642714-26879-1-git-send-email-olof@lixom.net>
References: <1355642714-26879-1-git-send-email-olof@lixom.net>
Message-ID: <CAKG51UAjooaCx=2KQUF-V9OqWTrE7MYZUy8dmthYD9AS0GTzHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 16, 2012, Olof Johansson wrote:

> arch/arm/mach-davinci/board-da850-evm.c: In function 'da850_evm_init':
> arch/arm/mach-davinci/board-da850-evm.c:1516:2: error: implicit
> declaration of function 'sram_get_gen_pool'
> [-Werror=implicit-function-declaration]
> arch/arm/mach-davinci/board-da850-evm.c:1516:31: warning: assignment makes
> pointer from integer without a cast [enabled by default]
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>
> I've added this to the 'fixes' branch on arm-soc.


Thanks for making the fix. In case you end up rebasing your branch,
please consider
adding:

Acked-by: Sekhar Nori <nsekhar at ti.com <javascript:_e({}, 'cvml',
'nsekhar@ti.com');>>

Thanks,
Sekhar


>  arch/arm/mach-davinci/board-da850-evm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c
> b/arch/arm/mach-davinci/board-da850-evm.c
> index 7211772..0299915 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -41,6 +41,7 @@
>  #include <mach/cp_intc.h>
>  #include <mach/da8xx.h>
>  #include <mach/mux.h>
> +#include <mach/sram.h>
>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> --
> 1.7.10.1.488.g05fbf7a
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121217/944643b5/attachment-0001.html>
