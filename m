From: Alexandre.Bounine@idt.com (Bounine, Alexandre)
Date: Mon, 7 Mar 2016 12:39:35 +0000
Subject: [TRIVIAL PATCH] treewide: Remove unnecessary 0x prefixes before
 %pa extension uses
In-Reply-To: <dcdebc08a17023fac93595312281cb8e91185668.1457162650.git.joe@perches.com>
References: <dcdebc08a17023fac93595312281cb8e91185668.1457162650.git.joe@perches.com>
Message-ID: <8D983423E7EDF846BB3056827B8CC5D15CFC6F84@corpmail1.na.ads.idt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Joe Perches [mailto:joe at perches.com]
> Sent: Saturday, March 05, 2016 2:47 AM
.....
> Subject: [TRIVIAL PATCH] treewide: Remove unnecessary 0x prefixes
> before %pa extension uses
> 
> Since commit 3cab1e711297 ("lib/vsprintf: refactor duplicate code
> to special_hex_number()") %pa uses have been ouput with a 0x prefix.
> 
> These 0x prefixes in the formats are unnecessary.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
....

>  drivers/rapidio/devices/rio_mport_cdev.c | 4 ++--
>  drivers/rapidio/devices/tsi721.c         | 8 ++++----

For RapidIO part -
Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>

.....

> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c
> b/drivers/rapidio/devices/rio_mport_cdev.c
> index a3369d1..211a67d 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -2223,7 +2223,7 @@ static void mport_mm_open(struct vm_area_struct
> *vma)
>  {
>  	struct rio_mport_mapping *map = vma->vm_private_data;
> 
> -rmcd_debug(MMAP, "0x%pad", &map->phys_addr);
> +	rmcd_debug(MMAP, "%pad", &map->phys_addr);
>  	kref_get(&map->ref);
>  }
> 
> @@ -2231,7 +2231,7 @@ static void mport_mm_close(struct vm_area_struct
> *vma)
>  {
>  	struct rio_mport_mapping *map = vma->vm_private_data;
> 
> -rmcd_debug(MMAP, "0x%pad", &map->phys_addr);
> +	rmcd_debug(MMAP, "%pad", &map->phys_addr);
>  	mutex_lock(&map->md->buf_mutex);
>  	kref_put(&map->ref, mport_release_mapping);
>  	mutex_unlock(&map->md->buf_mutex);
> diff --git a/drivers/rapidio/devices/tsi721.c
> b/drivers/rapidio/devices/tsi721.c
> index b5b4556..4c20e99 100644
> --- a/drivers/rapidio/devices/tsi721.c
> +++ b/drivers/rapidio/devices/tsi721.c
> @@ -1101,7 +1101,7 @@ static int tsi721_rio_map_inb_mem(struct
> rio_mport *mport, dma_addr_t lstart,
>  		ibw_start = lstart & ~(ibw_size - 1);
> 
>  		tsi_debug(IBW, &priv->pdev->dev,
> -			"Direct (RIO_0x%llx -> PCIe_0x%pad), size=0x%x,
> ibw_start = 0x%llx",
> +			"Direct (RIO_0x%llx -> PCIe_%pad), size=0x%x,
> ibw_start = 0x%llx",
>  			rstart, &lstart, size, ibw_start);
> 
>  		while ((lstart + size) > (ibw_start + ibw_size)) {
> @@ -1120,7 +1120,7 @@ static int tsi721_rio_map_inb_mem(struct
> rio_mport *mport, dma_addr_t lstart,
> 
>  	} else {
>  		tsi_debug(IBW, &priv->pdev->dev,
> -			"Translated (RIO_0x%llx -> PCIe_0x%pad), size=0x%x",
> +			"Translated (RIO_0x%llx -> PCIe_%pad), size=0x%x",
>  			rstart, &lstart, size);
> 
>  		if (!is_power_of_2(size) || size < 0x1000 ||
> @@ -1215,7 +1215,7 @@ static int tsi721_rio_map_inb_mem(struct
> rio_mport *mport, dma_addr_t lstart,
>  	priv->ibwin_cnt--;
> 
>  	tsi_debug(IBW, &priv->pdev->dev,
> -		"Configured IBWIN%d (RIO_0x%llx -> PCIe_0x%pad),
> size=0x%llx",
> +		"Configured IBWIN%d (RIO_0x%llx -> PCIe_%pad),
> size=0x%llx",
>  		i, ibw_start, &loc_start, ibw_size);
> 
>  	return 0;
> @@ -1237,7 +1237,7 @@ static void tsi721_rio_unmap_inb_mem(struct
> rio_mport *mport,
>  	int i;
> 
>  	tsi_debug(IBW, &priv->pdev->dev,
> -		"Unmap IBW mapped to PCIe_0x%pad", &lstart);
> +		"Unmap IBW mapped to PCIe_%pad", &lstart);
> 
>  	/* Search for matching active inbound translation window */
>  	for (i = 0; i < TSI721_IBWIN_NUM; i++) {
> --
> 2.6.3.368.gf34be46
