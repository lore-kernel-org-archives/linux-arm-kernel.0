From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 15:04:42 +0530
Subject: [PATCH] dmaengine: Add API documentation for slave dma usage
In-Reply-To: <BANLkTikn3BBeNyuUeZ9BhG5QLj-dmcGjTg@mail.gmail.com>
References: <1306238657-30089-1-git-send-email-vinod.koul@intel.com>
	<BANLkTikDPeEFWdsVQ=Ak8jXEXsC-+uoOaw@mail.gmail.com>
	<1306253171.30236.9.camel@vkoul-udesk3>
	<BANLkTikjxECNAK5eS5hSu2bbEKpZX341Dw@mail.gmail.com>
	<BANLkTikAm=D_YNFt0Regeas6AX8116L0-A@mail.gmail.com>
	<1306312009.30236.110.camel@vkoul-udesk3>
	<BANLkTikn3BBeNyuUeZ9BhG5QLj-dmcGjTg@mail.gmail.com>
Message-ID: <1306316082.30236.137.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 11:47 +0200, Per Forlin wrote:
> On 25 May 2011 10:26, Koul, Vinod <vinod.koul@intel.com> wrote:
> > I am okay with making this same for the slave devices as well.
> >
> > That would also require to change few drivers which start the txn in
> > submit()
> Yes,
> The trivial part is to move enable from submit to issue_pending. I had
> a quick look and it looks like the following drivers need to be
> changed.
> mpc512x_dma.c
> imx-dma.c
> imx-sdma.c
> mxs-dma.c
> 
> The other part is more complex. To make submit only add descs to a
> queue that will be pushed down to the DMA only after issue_pending. It
> is not as trivial to identify which of the drivers support this or
> not.
> I still think it make sense to fix the documentation first and then
> fix the drivers. Keep a list inside the dmaengine.txt of drivers that
> need to be fixed in order to comply with the API. Over time drivers
> will be fixed and removed from the list. When we have agreed upon the
> API (we may not be there yet) I am willingly to make a draft of such a
> list.
Yes this sounds right, I will send updated version and now drivers would
need to call issue_pending.

I know dw_dmac, intel_mid_dma and ste_dma40 would need changes as well.

Was thinking to add TODO in drivers/dma with these and any other changes
we feel are required moving forward.
We need dw_dmac to be moved to new slave interface and remove old slave
pointer mechanism when all are moved. 

-- 
~Vinod
