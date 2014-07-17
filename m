From: agross@codeaurora.org (Andy Gross)
Date: Thu, 17 Jul 2014 13:31:10 -0500
Subject: [PATCH] dmaengine: qcom_bam_dma: Add descriptor flags
In-Reply-To: <20140714163616.GA4387@intel.com>
References: <1401482990-26486-1-git-send-email-agross@codeaurora.org>
 <20140714163616.GA4387@intel.com>
Message-ID: <20140717183110.GB17951@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 10:06:16PM +0530, Vinod Koul wrote:
> On Fri, May 30, 2014 at 03:49:50PM -0500, Andy Gross wrote:
> > This patch adds support for end of transaction (EOT) and notify when done (NWD)
> > hardware descriptor flags.
> > 
> > The EOT flag requests that the peripheral assert an end of transaction interrupt
> > when that descriptor is complete.  It also results in special signaling protocol
> > that is used between the attached peripheral and the core using the DMA
> > controller.  Clients will specify DMA_PREP_INTERRUPT to enable this flag.
> > 
> > The NWD flag requests that the peripheral wait until the data has been fully
> > processed by the peripheral before moving on to the next descriptor.  Clients
> > will specify DMA_PREP_FENCE to enable this flag.
> 
> I am going to apply this, but pls send a follow up patch to add comments on the
> flags and their behaviour. I think it is required!

Will do.

<snip>

> >  #define DESC_FLAG_EOT BIT(14)
> >  #define DESC_FLAG_EOB BIT(13)
> > +#define DESC_FLAG_NWD BIT(12)
> explaining behvaiour will help..

In the followup, I'll put in a lengthy description of the INT/EOT/NWD and how
they are used in the signaling to/from the attached peripheral.


Thanks!

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
