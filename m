From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Mar 2010 10:39:44 -0800
Subject: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
In-Reply-To: <618f0c911003110708s5015f2bftb443b9ea57cb6477@mail.gmail.com>
References: <618f0c911003100612l33b1fec9s163720a5a93a1787@mail.gmail.com>
	<20100310224110.GW2900@atomide.com>
	<618f0c911003110708s5015f2bftb443b9ea57cb6477@mail.gmail.com>
Message-ID: <20100311183944.GJ2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Venkatraman S <svenkatr@ti.com> [100311 07:04]:
> Tony Lindgren wrote:
> >
> > Does the driver still work in PIO mode?
> >
> > We need to have the drivers capable to fail over to PIO mode
> > as the DMA channels can run out.
> >
> 
>    The driver doesn't have an automatic fallback to PIO,
> even without my patch. A error return from omap_request_dma is
> propogated all the way back to the transfer request.
>   The decision to use_dma (the variable) is unaltered.

OK, that might explain some nasty surprises then..

With these patches, does the driver still work in PIO mode though?
 
>    Infact, it would be easier to implement a runtime fallback after
> this patch is
> merged as I have separated out the capability and runtime selection.
> (dma_caps and dma_in_use).

Sounds good to me, thanks for looking into it.

Regards,

Tony
