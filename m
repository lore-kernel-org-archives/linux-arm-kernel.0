From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 7 Dec 2011 11:43:04 +0000
Subject: [PATCH] ARM: make head.S register assignments more convenient
In-Reply-To: <alpine.LFD.2.02.1112061357280.2357@xanadu.home>
References: <alpine.LFD.2.02.1112051528200.2357@xanadu.home>
 <20111206111105.GA2270@linaro.org>
 <20111206112912.GR14542@n2100.arm.linux.org.uk>
 <20111206132331.GA13769@linaro.org>
 <alpine.LFD.2.02.1112061357280.2357@xanadu.home>
Message-ID: <20111207114304.GB2910@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 02:01:23PM -0500, Nicolas Pitre wrote:
> On Tue, 6 Dec 2011, Dave Martin wrote:
> 
> > On Tue, Dec 06, 2011 at 11:29:12AM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Dec 06, 2011 at 11:11:05AM +0000, Dave Martin wrote:
> > > > Is it also worth changing the other proc-*.S setup rountines to be PCS
> > > > compliant too?  This would clean up the calling convention further, and
> > > > help avoid future sutprises.
> > > 
> > > They _aren't_ PCS functions in any case.  They don't have a stack
> > > available to them.  So, having them as non-PCS functions reinforces
> > > the fact that they _are_ special.
> > 
> > Fair point.
> > 
> > Maybe a brief note in the commit message explaining why only certain
> > proc-*.S files are touched would be belpful.  But it's not vital.
> 
> They are touched only because they were using registers where I moved 
> the previous r1 and r2 values to.  So I moved their usage of mainly 
> r5-r6 to the normally callee clobbered registers.  I don't think there 
> is further changes that would be as badly needed as those I did.

Fair enough
---Dave
