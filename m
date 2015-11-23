From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Nov 2015 15:41:45 +0100
Subject: [PATCH 1/2] dmaengine: at_xdmac: fix macro typo
In-Reply-To: <1448284184-15171-1-git-send-email-ludovic.desroches@atmel.com>
References: <1448284184-15171-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <565325A9.6020604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/11/2015 14:09, Ludovic Desroches a ?crit :
> Fix typo in a macro which was not used until now. It explains why there
> is no error at compilation time.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: e1f7c9eee707 "dmaengine: at_xdmac: creation of the atmel eXtended
> DMA Controller driver"
> Cc: stable at vger.kernel.org # 3.19 and later

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/dma/at_xdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 7f039de..d09277f 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -156,7 +156,7 @@
>  #define		AT_XDMAC_CC_WRIP	(0x1 << 23)	/* Write in Progress (read only) */
>  #define			AT_XDMAC_CC_WRIP_DONE		(0x0 << 23)
>  #define			AT_XDMAC_CC_WRIP_IN_PROGRESS	(0x1 << 23)
> -#define		AT_XDMAC_CC_PERID(i)	(0x7f & (h) << 24)	/* Channel Peripheral Identifier */
> +#define		AT_XDMAC_CC_PERID(i)	(0x7f & (i) << 24)	/* Channel Peripheral Identifier */
>  #define AT_XDMAC_CDS_MSP	0x2C	/* Channel Data Stride Memory Set Pattern */
>  #define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
>  #define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
> 


-- 
Nicolas Ferre
