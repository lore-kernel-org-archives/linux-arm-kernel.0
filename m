From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Jun 2015 13:52:57 +0900
Subject: [RFT v2 36/48] genirq,
 arm: Kill the first parameter 'irq' of irq_flow_handler_t
In-Reply-To: <1433391238-19471-37-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-37-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <556FD9A9.8090704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.06.2015 13:13, Jiang Liu wrote:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
> 
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> ---
>  arch/arm/common/it8152.c               |    2 +-
>  arch/arm/common/locomo.c               |    2 +-
>  arch/arm/common/sa1111.c               |    4 ++--
>  arch/arm/include/asm/hardware/it8152.h |    2 +-
>  arch/arm/include/asm/mach/irq.h        |    4 ++--
>  arch/arm/mach-dove/irq.c               |    4 ++--
>  arch/arm/mach-footbridge/isa-irq.c     |    4 ++--
>  arch/arm/mach-gemini/gpio.c            |    2 +-
>  arch/arm/mach-imx/3ds_debugboard.c     |    2 +-
>  arch/arm/mach-imx/mach-mx31ads.c       |    2 +-
>  arch/arm/mach-iop13xx/msi.c            |    2 +-
>  arch/arm/mach-lpc32xx/irq.c            |    4 ++--
>  arch/arm/mach-netx/generic.c           |    2 +-
>  arch/arm/mach-omap1/fpga.c             |    2 +-
>  arch/arm/mach-omap2/prm_common.c       |    2 +-
>  arch/arm/mach-pxa/balloon3.c           |    2 +-
>  arch/arm/mach-pxa/cm-x2xx-pci.c        |    4 ++--
>  arch/arm/mach-pxa/lpd270.c             |    2 +-
>  arch/arm/mach-pxa/pcm990-baseboard.c   |    2 +-
>  arch/arm/mach-pxa/viper.c              |    2 +-
>  arch/arm/mach-pxa/zeus.c               |    2 +-
>  arch/arm/mach-rpc/ecard.c              |    2 +-
>  arch/arm/mach-s3c24xx/bast-irq.c       |    3 +--
>  arch/arm/mach-s3c64xx/common.c         |    8 ++++----

For s3c24xx/s3c64xx:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
