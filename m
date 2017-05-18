From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 May 2017 10:45:13 +0100
Subject: [PATCH] arm64: mm: explicity include linux/vmalloc.h
In-Reply-To: <20170515114020.8198-1-tklauser@distanz.ch>
References: <20170515114020.8198-1-tklauser@distanz.ch>
Message-ID: <CAKv+Gu_N-2i=nANVnd+9Wvwv2J=74hyffOwA2mxjzi+_E9NxtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2017 at 12:40, Tobias Klauser <tklauser@distanz.ch> wrote:
> arm64's mm/mmu.c uses vm_area_add_early, struct vm_area and other
> definitions  but relies on implict inclusion of linux/vmalloc.h which
> means that changes in other headers could break the build. Thus, add an
> explicit include.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/mm/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 0c429ec6fde8..23c2d89a362e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -31,6 +31,7 @@
>  #include <linux/fs.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> +#include <linux/vmalloc.h>
>
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> --
> 2.13.0
>
>
