From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 7 Aug 2018 01:54:10 +0200
Subject: [RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign
 mtd->dev.parent, not mtd->owner
In-Reply-To: <20180806222918.12644-2-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-2-jmkrzyszt@gmail.com>
Message-ID: <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2018 12:29 AM, Janusz Krzysztofik wrote:
> Fix missing mtd->dev.parent assignment and drop useless mtd->owner.

You fail to explain why this fix is required.

> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 2a8872ebd14a..af313c620264 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -162,7 +162,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  	}
>  
>  	ams_delta_mtd = nand_to_mtd(this);
> -	ams_delta_mtd->owner = THIS_MODULE;
> +	ams_delta_mtd->dev.parent = &pdev->dev;
>  
>  	/*
>  	 * Don't try to request the memory region from here,
> 


-- 
Best regards,
Marek Vasut
