From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 29 Jun 2011 15:50:56 -0700
Subject: [PATCH 1/1] net/fec: iMX53 needs gasket for both MII and RMII
In-Reply-To: <1309387098-30680-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1309387098-30680-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <4E0BAC50.3030007@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/29/2011 3:38 PM, Troy Kisky wrote:
> Currently, only RMII interfaces are using the gasket.
> But, the iMX53 needs to enable the gasket for MII
> mode as well. The iMX51 has no gasket registers. So,
> add a use_gasket field to fec_platform_data to not restrict
> same kernel for both iMX51/53 boards.
> 
> iMX28 boards don't need use_gasket, as they have
> FEC_QUIRK_ENET_MAC.
> ---
>  arch/arm/mach-mx5/board-mx50_rdp.c  |    1 +
>  arch/arm/mach-mx5/board-mx53_evk.c  |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |    1 +
>  arch/arm/mach-mx5/board-mx53_smd.c  |    1 +
>  drivers/net/fec.c                   |   11 ++++++++---
>  include/linux/fec.h                 |    1 +
>  6 files changed, 13 insertions(+), 3 deletions(-)
...
> diff --git a/include/linux/fec.h b/include/linux/fec.h
> index bcff455..c0a7ad8 100644
> --- a/include/linux/fec.h
> +++ b/include/linux/fec.h
> @@ -19,6 +19,7 @@
>  struct fec_platform_data {
>  	phy_interface_t phy;
>  	unsigned char mac[ETH_ALEN];
> +	unsigned use_gasket : 1;
>  };
>  
>  #endif

I'll repost with checkpatch.pl fixes if approved.

Thanks
Troy
