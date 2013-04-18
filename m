From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 11:43:38 +0100
Subject: [PATCH 03/32] dmaengine: ste_dma40: Use the BIT macro to
 replace ugly '(1 << x)'s
In-Reply-To: <1366279934-30761-4-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20130418104338.GM14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 11:11:45AM +0100, Lee Jones wrote:
> The aim is to make the code that little more readable.

Maybe we should also invent the MULT() macro too, because a * b is just
too ugly as well?  Maybe ADD(), SUB() and DIV() macros as well...  Think
of all those extra parens you could use! :)

> @@ -1448,7 +1448,7 @@ static u32 d40_residue(struct d40_chan *d40c)
>  			  >> D40_SREG_ELEM_PHY_ECNT_POS;
>  	}
>  
> -	return num_elt * (1 << d40c->dma_cfg.dst_info.data_width);
> +	return num_elt * BIT(d40c->dma_cfg.dst_info.data_width);

This should be:
	return num_elt << d40c->dma_cfg.dst_info.data_width;
