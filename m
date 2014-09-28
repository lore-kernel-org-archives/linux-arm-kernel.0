From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Sun, 28 Sep 2014 21:53:57 +0530
Subject: [PATCH] arm: Remove read of issue in sa1111.c in sa1111_resume
In-Reply-To: <1411872652-16207-1-git-send-email-yocto6@gmail.com>
References: <1411872652-16207-1-git-send-email-yocto6@gmail.com>
Message-ID: <20140928162357.GA2542@sudip-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 10:50:52PM -0400, Nicholas Krause wrote:
> This removes the FIXME message and issue with reading in this driver before resuming
> in the function, sa1111_resume.
> 
> Signed-off-by: Nicholas Krause <yocto6@gmail.com>
> ---
>  arch/arm/common/sa1111.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index e57d7e5..0c4b9a9 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -950,9 +950,7 @@ static int sa1111_resume(struct platform_device *dev)
>  
>  	/*
>  	 * Ensure that the SA1111 is still here.
> -	 * FIXME: shouldn't do this here.
>  	 */
> -	id = sa1111_readl(sachip->base + SA1111_SKID);

do you understand the effect of removing this???
what is the value of id in the next part of the code?

thanks
sudip
>  	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
>  		__sa1111_remove(sachip);
>  		platform_set_drvdata(dev, NULL);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
