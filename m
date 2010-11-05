From: alex@digriz.org.uk (Alexander Clouter)
Date: Fri, 5 Nov 2010 20:28:34 +0000
Subject: [PATCH] TS-78xxx NAND resource type should be IORESOURCE_MEM
References: <1288977280-5674-1-git-send-email-mspang@csclub.uwaterloo.ca>
Message-ID: <i06eq7-6va.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In gmane.linux.kernel Michael Spang <mspang@csclub.uwaterloo.ca> wrote:
>
> The type was IORESOURCE_IO which is not what is expected by
> plat_nand_probe(). This device has not worked since 2d098a72
> ("mtd: plat_nand: request memory resource before doing ioremap").
> 
> Signed-off-by: Michael Spang <mspang@csclub.uwaterloo.ca>
>
Acked-by: Alexander Clouter <alex@digriz.org.uk>

Cheers

> ---
> arch/arm/mach-orion5x/ts78xx-setup.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index 16f1bd5..c1c1cd0 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -239,7 +239,7 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
> static struct resource ts78xx_ts_nand_resources = {
>        .start          = TS_NAND_DATA,
>        .end            = TS_NAND_DATA + 4,
> -       .flags          = IORESOURCE_IO,
> +       .flags          = IORESOURCE_MEM,
> };
> 
> static struct platform_device ts78xx_ts_nand_device = {
> -- 
> 1.7.1

-- 
Alexander Clouter
.sigmonster says: 98% lean.
