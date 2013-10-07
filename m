From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 7 Oct 2013 16:11:32 +0530
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
Message-ID: <20131007104132.GI2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 12:45:33PM +0200, Guennadi Liakhovetski wrote:
> On Sun, 6 Oct 2013, Vinod Koul wrote:
> > > > Do you see any problems using, say, a threaded interrupt handler, apart 
> > > > from possible performance issues? That seems to be pretty convenient. 
> > > > Otherwise we should really mandate somewhere, that bottom half processing 
> > > > should take place in a tasklet?
> > > 
> > > The documentation has always stated that callbacks will be made from
> > > tasklet context.  The problem with allowing different contexts from
> > > different drivers is taht spinlocking becomes problematical.  Remember
> > > that we have _bh() variants which lock against tasklets but allow IRQs.
> 
> Vinod, Dan, what do you think about the bottom half interrupt processing? 
> Do we want to make the use of a tasklet compulsory or can we also allow 
> other contexts?
I dont see any advantage of using threaded handler as compared to tasklet, As
Russell pointed out its going to make locking and common handling very
complicated to be invoked from different contexts. What will be benefit from
this?

--
~Vinod
