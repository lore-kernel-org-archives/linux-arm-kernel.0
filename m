From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Aug 2016 14:02:40 +0200
Subject: [PATCH v3 3/4] arm64: kaslr: Fix incorrect placement of
 __initdata and __read_mostly
In-Reply-To: <1470988871-2799-4-git-send-email-jszhang@marvell.com>
References: <1470988871-2799-1-git-send-email-jszhang@marvell.com>
 <1470988871-2799-4-git-send-email-jszhang@marvell.com>
Message-ID: <CAKv+Gu_ci37u6av9gjchBTVwoMCiqdnwtnDHxLT3cV3+kG0wUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On 12 August 2016 at 10:01, Jisheng Zhang <jszhang@marvell.com> wrote:
> __initdata and __read_mostly should be placed after the variable name
> for the variable to be placed in the intended section.
>

Why?

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/kernel/kaslr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index b054691..8ebabc4 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -20,8 +20,8 @@
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
>
> -u64 __read_mostly module_alloc_base;
> -u16 __initdata memstart_offset_seed;
> +u64 module_alloc_base __read_mostly;
> +u16 memstart_offset_seed __initdata;
>
>  static __init u64 get_kaslr_seed(void *fdt)
>  {
> --
> 2.8.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
