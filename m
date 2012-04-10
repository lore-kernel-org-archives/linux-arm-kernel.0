From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 10 Apr 2012 14:24:58 -0500
Subject: [PATCH v3 4/9] ARM: OMAP2+: gpmc-nand: populate gpmc configs
In-Reply-To: <6c120ab77d0900a6f977246bc58fb37c62280371.1333640054.git.afzal@ti.com>
References: <cover.1333640054.git.afzal@ti.com>
 <6c120ab77d0900a6f977246bc58fb37c62280371.1333640054.git.afzal@ti.com>
Message-ID: <4F84890A.30500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 04/05/2012 10:46 AM, Afzal Mohammed wrote:
> Currently gpmc is configured in platform for nand.
> As configuring gpmc has been moved to gpmc driver,
> populate details needed for the driver to configure
> gpmc. gpmc driver would configure based on this
> information.
>
> Signed-off-by: Afzal Mohammed<afzal@ti.com>
> ---
>   arch/arm/mach-omap2/gpmc-nand.c        |   97 ++++++++++++++------------------
>   arch/arm/plat-omap/include/plat/nand.h |    8 ++-
>   2 files changed, 48 insertions(+), 57 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 386dec8..85de31f 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -21,24 +21,38 @@
>   #include<plat/board.h>
>   #include<plat/gpmc.h>
>
> -static struct resource gpmc_nand_resource = {
> -	.flags		= IORESOURCE_MEM,
> +
> +#define	GPMC_NAND_CONFIG_NUM	4

Where does 4 come from?

Jon
