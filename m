From: B08248@freescale.com (Yoder Stuart-B08248)
Date: Mon, 5 Aug 2013 14:50:33 +0000
Subject: [PATCH 2/3] Initial skeleton of VFIO support for Device Tree
 based devices
In-Reply-To: <1375708632-26356-3-git-send-email-a.motakis@virtualopensystems.com>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
 <1375708632-26356-3-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503663FB7@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 284ff24..1e4bef2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -147,6 +147,7 @@ struct vfio_device_info {
>  	__u32	flags;
>  #define VFIO_DEVICE_FLAGS_RESET	(1 << 0)	/* Device supports reset
> */
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
> +#define VFIO_DEVICE_FLAGS_DT	(1 << 2)	/* vfio-dt device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };

In the RFC I sent out the proposed flags were:

   #define VFIO_DEVICE_FLAGS_PLATFORM (1 << ?) /* A platform bus device */
   #define VFIO_DEVICE_FLAGS_DEVTREE  (1 << ?) /* device tree info available */

Since you are only implementing the first part, the platform
device support, just call it:  VFIO_DEVICE_FLAGS_PLATFORM

I think the 'platform' term is more accurate as we are providing
a mechanism to expose devices on the /sys/bus/platform bus to
user space.

Stuart
