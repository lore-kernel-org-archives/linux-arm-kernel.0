From: rdunlap@infradead.org (Randy Dunlap)
Date: Sat, 27 Sep 2014 20:31:27 -0700
Subject: [PATCH] arm: Remove read of issue in sa1111.c in sa1111_resume
In-Reply-To: <1411872652-16207-1-git-send-email-yocto6@gmail.com>
References: <1411872652-16207-1-git-send-email-yocto6@gmail.com>
Message-ID: <5427810F.2000305@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/14 19:50, Nicholas Krause wrote:
> This removes the FIXME message and issue with reading in this driver before resuming
> in the function, sa1111_resume.

You need to explain why this makes any sense.
Hint:  it doesn't.

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
>  	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
>  		__sa1111_remove(sachip);
>  		platform_set_drvdata(dev, NULL);
> 


-- 
~Randy
