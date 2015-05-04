From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 4 May 2015 12:42:56 +0900
Subject: [PATCH 1/3] ARM: s3c24xx: add dma_coherent_mask for DMA devices
In-Reply-To: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
References: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
Message-ID: <CAJKOXPfbF0RDPisY-PvKKKVT1kHDrR60b7VmcjTkco5UPm-WTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-04 3:15 GMT+09:00 Vasily Khoruzhick <anarsoul@gmail.com>:
> Otherwise dma_alloc_coherent() fails.

Could you say few more words about the failure?
Also the patch looks like a candidate for CC-stable along with Fixes tag.

>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c24xx/common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
> index bf50328..7ed0853 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -355,6 +355,7 @@ struct platform_device s3c2410_device_dma = {
>         .resource       = s3c2410_dma_resource,
>         .dev    = {
>                 .platform_data  = &s3c2410_dma_platdata,
> +               .coherent_dma_mask = ~0,

DMA_BIT_MASK(32)?

>         },
>  };
>  #endif
> @@ -452,6 +453,7 @@ struct platform_device s3c2440_device_dma = {
>         .resource       = s3c2410_dma_resource,
>         .dev    = {
>                 .platform_data  = &s3c2440_dma_platdata,
> +               .coherent_dma_mask = ~0,

Ditto.

Best regards,
Krzysztof
