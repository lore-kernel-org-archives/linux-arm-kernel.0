From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 13:06:59 +0000
Subject: arm cortex_a9_mpcore timer: local timer and global timer
In-Reply-To: <AANLkTikt+CzkLBR5OCnjPUSLaLtuuBvGFSJVj+t0rRc2@mail.gmail.com>
References: <AAD1C6EB06EE3649B35B7E026785068D15345BE603@SC-VEXCH2.marvell.com>
	<AANLkTikt+CzkLBR5OCnjPUSLaLtuuBvGFSJVj+t0rRc2@mail.gmail.com>
Message-ID: <20101216130659.GS9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 12:59:13PM +0000, Catalin Marinas wrote:
> On 16 December 2010 02:02, Chao Xie <cxie4@marvell.com> wrote:
> > In the latest arm kernel, I find that smp_twd.c has implemented local timer for cortex a9 MPcore. In the spec, there is global timer that shared by all MPcore. I did not find any implements in the arm kernel. What is the strategy of using these two kinds of timer? I find that some SOCs have additional timer which is not the local timer or global timer in MPcore. Then what is the strategy of using this kind of timer with local timer and global timer in the kernel? Thanks.
> 
> We currently don't have any support for the global timer available on
> Cortex-A9. It is on our to-do list but not sure when we'll have time
> (unless someone else does it before :)).
> 
> On the current smp_twd.c implementation, a global timer is required to
> calibrate the local timers. So far we use the SP804 on the RealView
> and Versatile Express boards but we could, at some point, move to the
> global timer on A9.

MSM brings up an interesting point through - it only has local timers.
