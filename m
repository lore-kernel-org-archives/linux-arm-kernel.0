From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 11:43:33 +0100
Subject: [PATCH v2] spi: atmel: Implements transfers with bounce buffer
In-Reply-To: <1513093032-11570-1-git-send-email-radu.pirea@microchip.com>
References: <1513093032-11570-1-git-send-email-radu.pirea@microchip.com>
Message-ID: <20171219104333.GL15162@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2017 at 17:37:12 +0200, Radu Pirea wrote:
> This patch enables DMA transfers for Atmel SAM9 SoCs and implements a bounce
> buffer for transfers which have vmalloc allocated buffers. Those buffers are
> not cache coherent even if they have been transformed into sg lists. UBIFS
> is affected by this cache coherency issue.
> 
> In this patch I also reverted "spi: atmel: fix corrupted data issue on SAM9
> family SoCs"(7094576ccdc3acfe1e06a1e2ab547add375baf7f).
> 
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  Please ignore the previous version. I messed up with file names.
>  drivers/spi/spi-atmel.c | 113 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 84 insertions(+), 29 deletions(-)
> 

There are multiple checkpatch issues, can you fix them?

> +		if(!as->use_dma)

Especially that missing space.

> +			dev_info(master->dev.parent,
> +				"  can not allocate dma coherent memory\n");
> +	}
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
