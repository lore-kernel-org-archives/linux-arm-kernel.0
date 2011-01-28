From: tony@atomide.com (Tony Lindgren)
Date: Thu, 27 Jan 2011 16:26:21 -0800
Subject: [PATCH 1/2] arch/arm/mach-omap2/dma.c: Convert IS_ERR result
	to PTR_ERR
In-Reply-To: <20110127210225.07de155f.jhnikula@gmail.com>
References: <1296143347-17508-1-git-send-email-julia@diku.dk>
	<20110127210225.07de155f.jhnikula@gmail.com>
Message-ID: <20110128002620.GR23412@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [110127 11:03]:
> On Thu, 27 Jan 2011 16:49:06 +0100
> Julia Lawall <julia@diku.dk> wrote:
> 
> > diff -u -p a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> > --- a/arch/arm/mach-omap2/dma.c
> > +++ b/arch/arm/mach-omap2/dma.c
> > @@ -264,7 +264,7 @@ static int __init omap2_system_dma_init_
> >  	if (IS_ERR(od)) {
> >  		pr_err("%s: Cant build omap_device for %s:%s.\n",
> >  			__func__, name, oh->name);
> > -		return IS_ERR(od);
> > +		return PTR_ERR(od);
> >  	}
> >  
> FWIW,
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks, will queue as a fix during the -rc cycle.

Tony
