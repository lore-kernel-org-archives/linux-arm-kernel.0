From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 26 Apr 2011 09:54:41 +0530
Subject: [PATCH v2 1/5] dmaengine: at_hdmac: modify way to use interrupts
In-Reply-To: <20110426043408.GG12904@game.jcrosoft.org>
References: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
	<3ee5a0e314a22339ad7a15a5425045f5ed244eab.1303493836.git.nicolas.ferre@atmel.com>
	<1303790574.896.11.camel@vkoul-udesk3>
	<20110426043408.GG12904@game.jcrosoft.org>
Message-ID: <1303791881.896.18.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-04-26 at 10:04 +0530, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> On 09:32 Tue 26 Apr     , Koul, Vinod wrote:
> > On Fri, 2011-04-22 at 19:41 +0200, Nicolas Ferre wrote:
> > > Now we use Buffer Transfer Completed interrupts. If we
> > > want a chained buffer completed information, we setup the
> > > ATC_IEN bit in CTRLB register in the lli.
> > > This is done by set_desc_eol() function and used by
> > > memcpy/slave_sg functions.
> > > 
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  drivers/dma/at_hdmac.c      |    4 ++--
> > >  drivers/dma/at_hdmac_regs.h |   11 ++++++++---
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > > 
> > >  
> > Looks like your forgot to run checkpatch
> > WARNING: line over 80 characters
> > #401: FILE: drivers/dma/at_hdmac_regs.h:106:
> > +#define MEM_IF			0		/* specify AHB interface 0 as memory interface */
> > 
> > WARNING: line over 80 characters
> > #402: FILE: drivers/dma/at_hdmac_regs.h:107:
> > +#define PER_IF			1		/* specify AHB interface 1 as peripheral interface
> > */
> > 
> > WARNING: line over 80 characters
> > #689: FILE: drivers/dma/at_hdmac.c:899:
> > +			direction == DMA_TO_DEVICE ? "TO DEVICE" : "FROM DEVICE",
> > 
> > total: 0 errors, 3 warnings, 465 lines checked
> > 
> > While I am okay with 3rd one, you can easily reformat code for first two
> > and avoid these two warnings...
> It's comments it make it more readable
And that's why it can be easily reformatted without sacrificing code
readability and also avoid the warnings.
These warnings should be removed wherever its possible without
sacrificing code readability, something like:
+/* AHB interface defines */
+#define MEM_IF 0 /* 0 as memory interface */
+#define PER_IF 1 /* 1 as peripheral interface

and while at it, you need to fix these for namespace

-- 
~Vinod
