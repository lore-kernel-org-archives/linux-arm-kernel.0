From: vkoul@kernel.org (Vinod)
Date: Tue, 2 Oct 2018 20:28:20 +0530
Subject: [PATCH v5 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
In-Reply-To: <CAN8YU5PWB0sRskcirCcYnY5vG5A_W6pcOMpgyOD3faWfMeu5Rg@mail.gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-2-andrea.merello@gmail.com>
 <20180918162105.GC2613@vkoul-mobl>
 <CAN8YU5PWB0sRskcirCcYnY5vG5A_W6pcOMpgyOD3faWfMeu5Rg@mail.gmail.com>
Message-ID: <20181002145820.GH19792@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28-09-18, 09:11, Andrea Merello wrote:
> On Tue, Sep 18, 2018 at 6:21 PM Vinod <vkoul@kernel.org> wrote:

> > > @@ -1804,7 +1817,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
> > >                        * Calculate the maximum number of bytes to transfer,
> > >                        * making sure it is less than the hw limit
> > >                        */
> > > -                     copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
> > > +                     copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),
> >
> > why not keep chan in patch 1 and add only handling in patch 2, seems
> > less churn to me..
> 
> Indeed this was something I was unsure about.. I ended up in feeling
> better not to add introduce a function that takes an unused (yet)
> argument, but I can change this of course :)

IMO It is fine to add a user in subsequent patch in a series. Not fine to
add something and not use in "that" series :)

-- 
~Vinod
