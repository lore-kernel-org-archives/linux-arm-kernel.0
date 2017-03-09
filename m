From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 9 Mar 2017 08:37:18 +0100
Subject: [PATCH] dma: xilinx: Make Xilinx VDMA support ARC
In-Reply-To: <ec057c7b16c414a1cf9a9eba87c33f8bcf9f01f9.1488803103.git.roliveir@synopsys.com>
References: <ec057c7b16c414a1cf9a9eba87c33f8bcf9f01f9.1488803103.git.roliveir@synopsys.com>
Message-ID: <1ff465a7-69ed-6cd1-0e02-4b9ff752b3cd@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 06-03-17 13:27, Ramiro Oliveira wrote:
> Add option in Kconfig to use Xilinx VDMA in ARC processors.
>
> Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 263495d0adbd..b6b6c0581ad7 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -546,7 +546,7 @@ config XGENE_DMA
>
>  config XILINX_DMA
>  	tristate "Xilinx AXI DMAS Engine"
> -	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> +	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64|| ARC)

One can put a Xilinx FPGA on a PCIe card, instantiate a PCIe-AXI bridge and 
then use it on any platform that supports PCIe.

I've had to remove this line in order to be able to use the engine on an x86 
desktop.

How about plainly removing this "depends on" line and be done with it, instead 
of adding platforms one by one?


>  	select DMA_ENGINE
>  	help
>  	  Enable support for Xilinx AXI VDMA Soft IP.
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
