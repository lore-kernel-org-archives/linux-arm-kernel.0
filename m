From: jhnikula@gmail.com (Jarkko Nikula)
Date: Thu, 27 Jan 2011 21:02:25 +0200
Subject: [PATCH 1/2] arch/arm/mach-omap2/dma.c: Convert IS_ERR result to
	PTR_ERR
In-Reply-To: <1296143347-17508-1-git-send-email-julia@diku.dk>
References: <1296143347-17508-1-git-send-email-julia@diku.dk>
Message-ID: <20110127210225.07de155f.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Jan 2011 16:49:06 +0100
Julia Lawall <julia@diku.dk> wrote:

> diff -u -p a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -264,7 +264,7 @@ static int __init omap2_system_dma_init_
>  	if (IS_ERR(od)) {
>  		pr_err("%s: Cant build omap_device for %s:%s.\n",
>  			__func__, name, oh->name);
> -		return IS_ERR(od);
> +		return PTR_ERR(od);
>  	}
>  
FWIW,

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
