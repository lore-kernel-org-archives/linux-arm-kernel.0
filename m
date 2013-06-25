From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jun 2013 19:30:51 +0100
Subject: [RFC PATCH v2 01/12] dmaengine: PL08x: Refactor
 pl08x_getbytes_chan() to lower indentation
In-Reply-To: <20130625151612.GO23141@intel.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-2-git-send-email-tomasz.figa@gmail.com>
 <20130625151612.GO23141@intel.com>
Message-ID: <20130625183050.GA2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 08:46:12PM +0530, Vinod Koul wrote:
> On Sat, Jun 22, 2013 at 10:42:33PM +0200, Tomasz Figa wrote:
> > -			BUG_ON(clli < llis_bus || clli >= llis_bus +
> > +	llis_va = txd->llis_va;
> > +	llis_bus = txd->llis_bus;
> > +
> > +	BUG_ON(clli < llis_bus || clli >= llis_bus +
> >  				sizeof(struct pl08x_lli) * MAX_NUM_TSFR_LLIS);
> IMO BUG_ON is too much for this. Perhaps returning error and logging error would
> be okay

That should be a separate patch, because that's an unrelated change
to this patch.  As this part is just reformatting this part of the
code, it should contain no actual changes.

There's lots that this driver "should" do differently...
