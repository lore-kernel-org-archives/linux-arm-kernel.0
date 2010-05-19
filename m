From: error27@gmail.com (Dan Carpenter)
Date: Wed, 19 May 2010 21:48:54 +0200
Subject: [patch] nuc900fb: release correct mem region
In-Reply-To: <20100325105408.GD5069@bicker>
References: <20100325105408.GD5069@bicker>
Message-ID: <20100519194854.GB22515@bicker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.  Any feedback on this patch?

regards,
dan carpenter

On Thu, Mar 25, 2010 at 01:54:08PM +0300, Dan Carpenter wrote:
> We should be releasing "res->start" here.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> BTW.  Congratulations on being an official driver maintainer now.  :)  Can
> you add yourself to the MAINTAINERS file?
> 
> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> index 6bf0d46..d4cde79 100644
> --- a/drivers/video/nuc900fb.c
> +++ b/drivers/video/nuc900fb.c
> @@ -667,7 +667,7 @@ release_irq:
>  release_regs:
>  	iounmap(fbi->io);
>  release_mem_region:
> -	release_mem_region((unsigned long)fbi->mem, size);
> +	release_mem_region(res->start, size);
>  free_fb:
>  	framebuffer_release(fbinfo);
>  	return ret;
