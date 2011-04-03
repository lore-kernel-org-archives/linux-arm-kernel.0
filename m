From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Apr 2011 11:03:03 +0100
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <AANLkTikqYMe4LFDAPqJf36vYVTBXDE=JD_AW4rNrTp2e@mail.gmail.com>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<AANLkTikqYMe4LFDAPqJf36vYVTBXDE=JD_AW4rNrTp2e@mail.gmail.com>
Message-ID: <20110403100303.GA4213@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2011 at 12:37:11PM +0900, Magnus Damm wrote:
> On Sat, Apr 2, 2011 at 5:51 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Apr 01, 2011 at 04:55:02PM -0600, Grant Likely wrote:
> >> On Fri, Apr 1, 2011 at 4:26 PM, John Linn <John.Linn@xilinx.com> wrote:
> >> > I?m getting ready to submit a patch to add SMP to Xilinx code. I notice that
> >> > smp_cross_call for all GIC based platforms is duplicated across each
> >> > platform in smp.h.
> >> >
> >> >
> >> >
> >> > I thought I?d try to jump in to help with some cleanup, although I realize
> >> > it?s minimal, I have to start somewhere.
> >> >
> >> >
> >> >
> >> > What about moving the smp_cross_call for GIC based designs into gic.h?
> >>
> >> Go for it. ?It's an obvious cleanup.
> >
> > That assumes that all SMP implementations will always have a GIC. ?It
> > looks to me like this is conditional on shmobile, and so I don't think
> > its that trivial - maybe Paul or Magnus can first indicate why this is.
> 
> Our SMP implementations all come with GIC. All shmobile SoCs don't
> come with SMP though, so the conditional is most likely related to
> that.

On platforms without SMP, mach/smp.h shouldn't be included, so the code
in mach/smp.h won't be seen by the compiler.  So, I think you can get
rid of that conditional.
