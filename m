From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 12:00:09 +0100
Subject: [PATCH 03/32] dmaengine: ste_dma40: Use the BIT macro to replace
 ugly '(1 << x)'s
In-Reply-To: <20130418104338.GM14496@n2100.arm.linux.org.uk>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-4-git-send-email-lee.jones@linaro.org>
 <20130418104338.GM14496@n2100.arm.linux.org.uk>
Message-ID: <20130418110009.GA27903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Apr 2013, Russell King - ARM Linux wrote:

> On Thu, Apr 18, 2013 at 11:11:45AM +0100, Lee Jones wrote:
> > The aim is to make the code that little more readable.
> 
> Maybe we should also invent the MULT() macro too, because a * b is just
> too ugly as well?  Maybe ADD(), SUB() and DIV() macros as well...  Think
> of all those extra parens you could use! :)

Very amusing. :)

I just happen to like this macro.

It's more for tidiness than readability to be honest, but still.

> > @@ -1448,7 +1448,7 @@ static u32 d40_residue(struct d40_chan *d40c)
> >  			  >> D40_SREG_ELEM_PHY_ECNT_POS;
> >  	}
> >  
> > -	return num_elt * (1 << d40c->dma_cfg.dst_info.data_width);
> > +	return num_elt * BIT(d40c->dma_cfg.dst_info.data_width);
> 
> This should be:
> 	return num_elt << d40c->dma_cfg.dst_info.data_width;

Thanks. I'll fixup.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
