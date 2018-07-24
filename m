From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 24 Jul 2018 11:45:23 +0000
Subject: [PATCH v3 2/3] soc: imx: gpc: clean up
In-Reply-To: <1532425561377.1081@mixed-mode.de>
References: <1532425561377.1081@mixed-mode.de>
Message-ID: <73b2d272a68ba6a21c62857733f5333a30323fcc.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-24 at 09:46 +0000, Sven Schmitt wrote:
> Remove unused #defines.

This should be the title of the patch, "clean up" is too vague.

> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -24,15 +24,11 @@
>  #define GPC_PGC_CTRL_OFFS	0x0
>  #define GPC_PGC_PUPSCR_OFFS	0x4
>  #define GPC_PGC_PDNSCR_OFFS	0x8
> -#define GPC_PGC_SW2ISO_SHIFT	0x8
> -#define GPC_PGC_SW_SHIFT	0x0

It would be cleaner if you used these defines when reading the sw/iso
values.

>  
>  #define GPC_PGC_PCI_PDN		0x200
>  #define GPC_PGC_PCI_SR		0x20c
>  
>  #define GPC_PGC_GPU_PDN		0x260
> -#define GPC_PGC_GPU_PUPSCR	0x264
> -#define GPC_PGC_GPU_PDNSCR	0x268
>  #define GPC_PGC_GPU_SR		0x26c

Each PGC has a fixed size and layout, maybe we could just have defines
for the offset of the PGC? It would be somewhat similar to gpcv2
