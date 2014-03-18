From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Mar 2014 20:54:44 +0530
Subject: [PATCH] dma: Add Keystone Packet DMA Engine driver
In-Reply-To: <53274F0B.5070201@ti.com>
References: <1393628200-12317-1-git-send-email-santosh.shilimkar@ti.com>
 <20140311102357.GR1976@intel.com> <531F6908.4010104@ti.com>
 <20140312160017.GY1976@intel.com> <5320CEC4.1060306@ti.com>
 <20140317044223.GA1976@intel.com> <53274F0B.5070201@ti.com>
Message-ID: <20140318152444.GC1976@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 03:37:47PM -0400, Santosh Shilimkar wrote:
> >> To simplify this bit more, you can think of this as DMA channels, flows
> >> are allocated and DMA channels are enabled by DMA engine and they remains
> >> enabled always as long as the channel in use. Enablling dma channel
> >> actually don't start the DMA transfer but just sets up the connection/pipe
> >> with peripheral and memory and vice a versa.
> >>
> >> All the descriptor management, triggering, sending completion interrupt or
> >> hardware signal to DMAEngine all managed by centralised QMSS.
> >>
> >> Actual copy of data is still done by DMA hardware but its completely
> >> transparent to software. DMAEngine hardware takes care of that in the
> >> backyard.
> > So you will use the dmaengine just for setting up the controller. Not for actual
> > transfers. Those would be governed by the QMSS, right?
> >
> Correct.
>  
> > This means that someone expecting to use dmaengine API will get confused about
> > this and doing part (alloc) thru dmaengine and rest (transfers) using some other
> > API. This brings to me the design approach, does it really make sense creating
> > dmaengine driver for this when we are not fully complying to the API
> > 
> Thats fair. The rationale behind usage of DMEngine was that its the closest
> available subsystem which can be leveraged for this hardware. We can
> pretty much use all the standard DMAEngine device tree parsing as well as
> the config API to setup DMAs. 
> 
> I think you made your stand clear, just to confirm, you don't prefer this
> driver to be a DMAEngine driver considering it doesn't fully complying to
> the APIs. We could document the deviation of 'transfer' handling to avoid
> any confusion.
Yup, a user will just get confused as the driver doenst conform the dmaengine
API. Unless someone comes up witha  strong argument on why it should be
dmaengine driver and what befits we see form such a model, i would like a
damengine driver to comply to standard API and usage.

-- 
~Vinod
