From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Nov 2013 11:13:39 -0800
Subject: [PATCH 01/28] dmaengine: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <20131030130325.GA18788@intel.com>
References: <20131017020745.GA14013@intel.com>
 <20131017142755.GA4477@breakpoint.cc>
 <20131017134846.GG14013@intel.com>
 <Pine.LNX.4.64.1310242326500.2900@axis700.grange>
 <20131025042310.GC21230@intel.com>
 <Pine.LNX.4.64.1310250813370.6186@axis700.grange>
 <20131025054321.GD21230@intel.com>
 <Pine.LNX.4.64.1310250840350.6186@axis700.grange>
 <CAOesGMivD_3zSL503R0OaqyGv4Rj8qJqnbM2TdmjtxR2U63ztw@mail.gmail.com>
 <20131030130325.GA18788@intel.com>
Message-ID: <20131111191339.GA10328@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 06:33:25PM +0530, Vinod Koul wrote:
> On Tue, Oct 29, 2013 at 09:47:55AM -0700, Olof Johansson wrote:
> > This patch broke some TI platforms (using edma) due to namespace
> > conflicts. The error is:
> > 
> > ../../include/linux/dmaengine.h:54:2: error: expected identifier
> > before numeric constant   (for DMA_COMPLETE)
> > 
> > .. it's because they define DMA_COMPLETE in include/platform_data/edma.h.
> > 
> > The edma driver seems to overall lack prefixes and thus pollutes
> > global namespaces, so it should be fixed up.
> Yup this needs some work.
> 
> I fixed up the error with below, can you pls verify. Pls note this is compile
> tested only!
> 
> -----><8---------------------------
> 
> From: Vinod Koul <vinod.koul@intel.com>
> Date: Wed, 30 Oct 2013 18:22:30 +0530
> Subject: [PATCH] dmanengine: fix edma driver to not define DMA_COMPLETE
> 
> edma header defines DMA_COMPLETE, this causes issues as commit adfedd9a32e4 move
> DMA_SUCCESS to DMA_COMPLETE. edma should properly namespace its defines and
> needs a future fix
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Thanks, I've applied this to fixes together with the follow-up from
Sebastian. Cc:ing Mark since it touches drivers/soc.


-Olof
