From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Jan 2013 17:05:01 +0000
Subject: [PATCH 1/4] ARM: cache-l2x0: Manage the errata at run time
In-Reply-To: <20130122054227.GA5594@bnru10>
References: <20130121131451.GA29855@bnru10>
 <20130121140344.GG18005@mudshark.cambridge.arm.com>
 <20130122054227.GA5594@bnru10>
Message-ID: <20130122170500.GG2153@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 05:42:29AM +0000, Srinidhi Kasagar wrote:
> On Mon, Jan 21, 2013 at 15:03:44 +0100, Will Deacon wrote:
> > On Mon, Jan 21, 2013 at 01:14:53PM +0000, srinidhi kasagar wrote:
> > > +asmlinkage u32 l2x0_get_rtl_release(void)
> > > +{
> > > +	return readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
> > > +			L2X0_CACHE_ID_RTL_MASK;
> > > +}
> > 
> > You're calling this function all over the place, including from the flush
> > code. Can you read the RTL release during probe and stash it somewhere
> > instead please?
> 
> I thought of doing that, however TI omap's suspend is the only one which needs
> this API as well, So, I had to make it global. Refer my patch 3/4. I can
> duplicate this for omap if you think so..

Just make the get_rtl_release_function return the stashed value if it's been
probed and get the driver to use the stashed value directly.

Will
