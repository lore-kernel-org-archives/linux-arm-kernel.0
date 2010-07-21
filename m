From: marcel@holtmann.org (Marcel Holtmann)
Date: Wed, 21 Jul 2010 10:58:54 -0700
Subject: [PATCH v2 01/20] sdio: add TI + wl1271 ids
In-Reply-To: <1279733634-21974-2-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-2-git-send-email-ohad@wizery.com>
Message-ID: <1279735134.3035.9.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

> Add SDIO IDs for TI and for TI's wl1271 wlan device.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  include/linux/mmc/sdio_ids.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 33b2ea0..0d313c6 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -43,4 +43,7 @@
>  #define SDIO_DEVICE_ID_SIANO_NOVA_A0		0x1100
>  #define SDIO_DEVICE_ID_SIANO_STELLAR 		0x5347
>  
> +#define SDIO_VENDOR_ID_TI			0x0097
> +#define SDIO_DEVICE_ID_TI_WL1271		0x4076
> +

are we still doing this non-sense for no real reason. What is so wrong
with keeping the IDs inside the driver code?

Personally I don't even see a point for these ID defines at all. Just
use the bare numbers in SDIO_DEVICE and put a comment above what kind of
device this is.

Regards

Marcel
