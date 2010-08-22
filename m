From: ccross@google.com (Colin Cross)
Date: Sat, 21 Aug 2010 22:21:16 -0700
Subject: [PATCH] arm: tegra: VMALLOC_END should be unsigned long
In-Reply-To: <20100818232647.GA23694@lixom.net>
References: <20100818232647.GA23694@lixom.net>
Message-ID: <AANLkTimnBU1oiA=60z7yxn24FhVCMZ1yRvwyLe+N91J2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 4:26 PM, Olof Johansson <olof@lixom.net> wrote:
> Silences following build warning:
>
> arch/arm/mm/init.c: In function 'mem_init':
> arch/arm/mm/init.c:644: warning: format '%08lx' expects type 'long
> unsigned int', but argument 12 has type 'unsigned int'
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> ?arch/arm/mach-tegra/include/mach/vmalloc.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/include/mach/vmalloc.h b/arch/arm/mach-tegra/include/mach/vmalloc.h
> index 267a141..fd6aa65 100644
> --- a/arch/arm/mach-tegra/include/mach/vmalloc.h
> +++ b/arch/arm/mach-tegra/include/mach/vmalloc.h
> @@ -23,6 +23,6 @@
>
> ?#include <asm/sizes.h>
>
> -#define VMALLOC_END ? ? ? ?0xFE000000
> +#define VMALLOC_END ? ? ? ?0xFE000000UL
>
> ?#endif
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

Ack, queued for an rc pull request
