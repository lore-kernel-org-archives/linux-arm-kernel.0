From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 22 Mar 2012 15:44:51 +0100
Subject: [PATCH 2/3] mmc: atmel-mci: r/w proof capability only available
 since v2xx
In-Reply-To: <1332344483-3915-3-git-send-email-ludovic.desroches@atmel.com>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
 <1332344483-3915-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4F6B3AE3.6080901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 04:41 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/mmc/host/atmel-mci.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index e161452..9dcb236 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2009,6 +2009,8 @@ static void __init atmci_get_cap(struct atmel_mci *host)
>  	/* keep only major version number */
>  	switch (version & 0xf00) {
>  	case 0x100:
> +		host->caps.has_pdc = 1;
> +		break;
>  	case 0x200:
>  		host->caps.has_pdc = 1;
>  		host->caps.has_rwproof = 1;


-- 
Nicolas Ferre
