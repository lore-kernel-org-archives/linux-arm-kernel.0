From: vkoul@kernel.org (Vinod)
Date: Wed, 30 May 2018 15:55:14 +0530
Subject: [RESEND PATCH] dmaengine: pxa: add a default requestor policy
In-Reply-To: <874liqtgul.fsf@belgarion.home>
References: <20180526095418.22960-1-robert.jarzmik@free.fr>
 <20180529072401.GG5666@vkoul-mobl> <874liqtgul.fsf@belgarion.home>
Message-ID: <20180530102514.GD16230@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-05-18, 21:13, Robert Jarzmik wrote:
> Vinod <vkoul@kernel.org> writes:
> 
> > On 26-05-18, 11:54, Robert Jarzmik wrote:
> >> @@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
> >>  	dma_pool_destroy(chan->desc_pool);
> >>  	chan->desc_pool = NULL;
> >>  
> >> +	chan->drcmr = (u32)-1;
> >
> > why not use U32_MAX for this?
> But of course, anything else you see ?

Nope that was the only one :)

-- 
~Vinod
