From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 2 Aug 2017 10:40:04 +0530
Subject: [PATCH v1 0/6] A series of patches support FSL qDma controller
In-Reply-To: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
References: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
Message-ID: <20170802051004.GX3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:14:05AM +0800, jiaheng.fan wrote:
> The FSL qDMA controller transfers blocks of data between one source
> and one destination.The blocks of data transferred can be represented
> in memory as contiguous or noncontiguous using scatter/gather table(s).
> Channel virtualization is supported through enqueuing of DMA jobs to,
> or dequeuing DMA jobs from, different work queues.
> 
> jiaheng.fan (6):
>   dma: fsl-dma: add devicetree documentation for qdma driver.
>   arm: linux: fsl: dma: add qdma command queue mode
>   dma: fsl-qdma: workaround for ERR010812
>   dma: fsl-qdma: add workaround for TKT329166

It's dmaengine: xxx

If you don't know please do check the git log on the subsystem you intend to
send patches on...


>   arm: dts: ls1021: add qdma node to dtsi
>   arm64: dts: ls1043/ls1046: add qdma note to dtsi
> 
>  Documentation/devicetree/bindings/dma/fsl-qdma.txt |   42 +
>  arch/arm/boot/dts/ls1021a.dtsi                     |   15 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   15 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   15 +
>  drivers/dma/Kconfig                                |   12 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/fsl-qdma.c                             | 1202 ++++++++++++++++++++
>  7 files changed, 1302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt
>  create mode 100644 drivers/dma/fsl-qdma.c
> 
> -- 
> 2.7.4
> 

-- 
~Vinod
