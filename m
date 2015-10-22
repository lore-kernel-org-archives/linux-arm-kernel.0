From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Oct 2015 12:13:30 +0200
Subject: [PATCH v2 3/6] vfio: platform: reset: calxedaxgmac: add reset
 function registration
In-Reply-To: <1445506922-6005-4-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
 <1445506922-6005-4-git-send-email-eric.auger@linaro.org>
Message-ID: <4810974.apRDTjc3oB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 October 2015 11:41:59 Eric Auger wrote:
> This patch adds the reset function registration/unregistration.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>

Looks good, except one thing:
> @@ -70,6 +69,8 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
>  			return -ENOMEM;
>  	}
>  
> +	pr_info("VFIO reset of %s\n", vdev->name);
> +
>  	/* disable IRQ */
>  	writel(0, reg.ioaddr + XGMAC_DMA_INTR_ENA);
>  

This probably slipped in from debugging, please remove it.

	Arnd
