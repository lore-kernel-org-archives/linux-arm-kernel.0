From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 Apr 2014 13:47:01 +0530
Subject: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
 default when booted with DT
In-Reply-To: <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5347A4FD.1030803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 April 2014 06:36 PM, Peter Ujfalusi wrote:
> Use the EVENTQ_1 for default and leave the EVENTQ_0 to be used by high
> priority channels, like audio.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

> ---
>  arch/arm/common/edma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 86a8b263278f..19520e2519d9 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1546,7 +1546,8 @@ static int edma_of_parse_dt(struct device *dev,
>  
>  	pdata->queue_priority_mapping = queue_priority_map;
>  
> -	pdata->default_queue = 0;
> +	/* select queue 1 as default */

It will be nice to expand the comment with explanation of why this is
being chosen as default (lower priority queue by default for typical
bulk data transfer).

Thanks,
Sekhar
