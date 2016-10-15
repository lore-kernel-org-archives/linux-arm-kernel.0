From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 15 Oct 2016 09:53:30 +0200 (CEST)
Subject: [PATCH 3/4] ARM: bcm2835: Add #define for VCHIQ property message.
In-Reply-To: <20161003185209.27733-4-eric@anholt.net>
References: <20161003185209.27733-1-eric@anholt.net>
 <20161003185209.27733-4-eric@anholt.net>
Message-ID: <487621239.358635.2bd73c71-f221-4323-833d-b752e7c41a53.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

> Eric Anholt <eric@anholt.net> hat am 3. Oktober 2016 um 20:52 geschrieben:
> 
> 
> This comes from the downstream tree and is needed for the new VCHIQ
> driver in staging.

maybe it's not clear from the commit message, but RPI_FIRMWARE_VCHIQ_INIT is
already used in
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c

So this patch fixes also a build issue.

> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  include/soc/bcm2835/raspberrypi-firmware.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h
> b/include/soc/bcm2835/raspberrypi-firmware.h
> index 3fb357193f09..a06baffdf580 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -109,6 +109,8 @@ enum rpi_firmware_property_tag {
>  	RPI_FIRMWARE_FRAMEBUFFER_SET_OVERSCAN =               0x0004800a,
>  	RPI_FIRMWARE_FRAMEBUFFER_SET_PALETTE =                0x0004800b,
>  
> +	RPI_FIRMWARE_VCHIQ_INIT =                             0x00048010,
> +
>  	RPI_FIRMWARE_GET_COMMAND_LINE =                       0x00050001,
>  	RPI_FIRMWARE_GET_DMA_CHANNELS =                       0x00060001,
>  };
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
