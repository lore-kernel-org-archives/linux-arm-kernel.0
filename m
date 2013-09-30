From: gerg@uclinux.org (Greg Ungerer)
Date: Tue, 01 Oct 2013 08:43:40 +1000
Subject: [PATCH] ARM: ks8695: fix incorrect placement of __initdata tag
In-Reply-To: <1551134.v305P4LSfh@amdc1032>
References: <1551134.v305P4LSfh@amdc1032>
Message-ID: <5249FE9C.2000208@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/13 23:02, Bartlomiej Zolnierkiewicz wrote:
> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Greg Ungerer <gerg@uclinux.org>


> ---
>   arch/arm/mach-ks8695/board-og.c | 2 +-
>   arch/arm/mach-ks8695/cpu.c      | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
> index 002bc61..9204f5a 100644
> --- a/arch/arm/mach-ks8695/board-og.c
> +++ b/arch/arm/mach-ks8695/board-og.c
> @@ -79,7 +79,7 @@ static void __init og_pci_bus_reset(void)
>   #define	S8250_VIRT	0xf4000000
>   #define	S8250_SIZE	0x00100000
>
> -static struct __initdata map_desc og_io_desc[] = {
> +static struct map_desc og_io_desc[] __initdata = {
>   	{
>   		.virtual	= S8250_VIRT,
>   		.pfn		= __phys_to_pfn(S8250_PHYS),
> diff --git a/arch/arm/mach-ks8695/cpu.c b/arch/arm/mach-ks8695/cpu.c
> index ddb2422..9618654 100644
> --- a/arch/arm/mach-ks8695/cpu.c
> +++ b/arch/arm/mach-ks8695/cpu.c
> @@ -33,8 +33,7 @@
>   #include <mach/regs-sys.h>
>   #include <mach/regs-misc.h>
>
> -
> -static struct __initdata map_desc ks8695_io_desc[] = {
> +static struct map_desc ks8695_io_desc[] __initdata = {
>   	{
>   		.virtual	= (unsigned long)KS8695_IO_VA,
>   		.pfn		= __phys_to_pfn(KS8695_IO_PA),
>
