From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 13 Oct 2013 20:26:42 +0530
Subject: [PATCH RESEND 0/3] ARM: S3C24XX: add missing dma-devices and
 warning fix
In-Reply-To: <201310111059.19791.heiko@sntech.de>
References: <201310111059.19791.heiko@sntech.de>
Message-ID: <20131013145642.GJ2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 10:59:19AM +0200, Heiko St?bner wrote:
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
Do you want this to be applied thru dma or arm tree?

~Vinod
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
> 
> -- 
> 1.7.10.4
> 

-- 
