From: t.figa@samsung.com (Tomasz Figa)
Date: Sat, 12 Oct 2013 06:38:50 +0200
Subject: [PATCH RESEND 0/3] ARM: S3C24XX: add missing dma-devices and
 warning fix
In-Reply-To: <201310111059.19791.heiko@sntech.de>
References: <201310111059.19791.heiko@sntech.de>
Message-ID: <3315189.7g6koLM0p3@amdn883>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

[Resending, due to my e-mail client enabling HTML formatting.
Sorry for the noise.]

On Friday 11 of October 2013 10:59:19 Heiko St?bner wrote:
> [I messed up the linux-arm-kernel list address yesterday, so I resend it
> with a fixed address, sorry for the noise]
> 
> When Olof reported the warning about the unused s3c2410_dma_resource, I
> thought the best way forward would be to simply implement the missing
> pieces and so it has users :-) .
> 
> Therefore this series adds the necessary platform-devices for s3c2410,
> s3c2440 and s3c2442. This especially also includes the channel-constraints
> of those socs.
> 
> As I do not have access to any of those socs these changes are of course
> compile-tested only.
> 
> Heiko Stuebner (3):
>   ARM: S3C24XX: Fix possible dma selection warning
>   dmaengine: s3c24xx-dma: add support for the s3c2410 type of controller
>   ARM: S3C24XX: add dma platformdata for s3c2410, s3c2440 and s3c2442
> 
>  arch/arm/mach-s3c24xx/Kconfig             |    3 +-
>  arch/arm/mach-s3c24xx/common.c            |  100 +++++++++++++++++++++++++++++
>  arch/arm/mach-s3c24xx/common.h            |    2 +
>  drivers/dma/s3c24xx-dma.c                 |   10 +++
>  include/linux/platform_data/dma-s3c24xx.h |    3 +
>  sound/soc/samsung/Kconfig                 |    2 +-
>  6 files changed, 118 insertions(+), 2 deletions(-)

Big thanks for this series and the one adding DMA engine support for
S3C24xx. It would be great if someone could test this on affected
platforms, so we could finally drop the old S3C-DMA nonsense.

Anyway, for the whole series

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
