From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 20 May 2011 19:18:35 +0400
Subject: [PATCH 4/4] davinci: create new common platform header for davinci
In-Reply-To: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
References: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4DD6864B.6040305@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Manjunath Hadli wrote:

> remove the code from individual platform header files for
> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file dmx.h.

    Could we call it davinci.h instead?

> Include the new header file in individual platform header
> files as a pre-cursor for deleting these headers in follow
> up patches.

> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
[...]

> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index c67f684..7be75b2 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
[...]
> @@ -143,6 +143,10 @@ static struct davinci_nand_pdata davinci_nand_data = {
>  	.ecc_bits		= 4,
>  };
>  
> +#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01D10000
> +#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
> +#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000

    No, we don't want to duplicate those in every future DM365 board file. Leave 
them in the header please.

> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index f6ac9ba..73497a6 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -91,6 +91,9 @@ static struct davinci_nand_pdata davinci_nand_data = {
>  	.options		= 0,
>  };
>  
> +#define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
> +#define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
> +

    No, we don't want to duplicate those in every future DM646x board file. 
Leave them in the header please.

> diff --git a/drivers/media/video/davinci/vpif_capture.h b/drivers/media/video/davinci/vpif_capture.h
> index fa50b6b..cafa762 100644
> --- a/drivers/media/video/davinci/vpif_capture.h
> +++ b/drivers/media/video/davinci/vpif_capture.h
> @@ -28,6 +28,7 @@
>  #include <media/v4l2-device.h>
>  #include <media/videobuf-core.h>
>  #include <media/videobuf-dma-contig.h>
> +#include <mach/dmx.h>

    Why, if it didn't #include any of the deleted headers before?

WBR, Sergei
