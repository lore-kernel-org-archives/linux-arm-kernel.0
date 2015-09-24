From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 24 Sep 2015 07:25:12 +0300
Subject: [PATCH] mxc_nand: fix copy_spare
In-Reply-To: <1443020848-28813-1-git-send-email-eric@eukrea.com>
References: <1443020848-28813-1-git-send-email-eric@eukrea.com>
Message-ID: <20150924042512.GC2229@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, Sep 23, 2015 at 05:07:28PM +0200, Eric B?nard wrote:
> it was broken by 35d5d20efad8a04c8c002c7f31241dff973977a6
> "mtd: mxc_nand: cleanup copy_spare function"
> 
> else we get the following error :

[long kernel oops resulting in:]

> Segmentation fault
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Baruch Siach <baruch@tkos.co.il>

Sorry for not catching it earlier.

Thanks,
baruch

> ---
>  drivers/mtd/nand/mxc_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 2426db8..f04445b 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -879,7 +879,7 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
>  				      oob_chunk_size);
>  
>  		/* the last chunk */
> -		memcpy16_toio(&s[oob_chunk_size * sparebuf_size],
> +		memcpy16_toio(&s[i * sparebuf_size],
>  			      &d[i * oob_chunk_size],
>  			      host->used_oobsize - i * oob_chunk_size);
>  	}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
