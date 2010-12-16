From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Dec 2010 12:59:13 +0000
Subject: arm cortex_a9_mpcore timer: local timer and global timer
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D15345BE603@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D15345BE603@SC-VEXCH2.marvell.com>
Message-ID: <AANLkTikt+CzkLBR5OCnjPUSLaLtuuBvGFSJVj+t0rRc2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2010 02:02, Chao Xie <cxie4@marvell.com> wrote:
> In the latest arm kernel, I find that smp_twd.c has implemented local timer for cortex a9 MPcore. In the spec, there is global timer that shared by all MPcore. I did not find any implements in the arm kernel. What is the strategy of using these two kinds of timer? I find that some SOCs have additional timer which is not the local timer or global timer in MPcore. Then what is the strategy of using this kind of timer with local timer and global timer in the kernel? Thanks.

We currently don't have any support for the global timer available on
Cortex-A9. It is on our to-do list but not sure when we'll have time
(unless someone else does it before :)).

On the current smp_twd.c implementation, a global timer is required to
calibrate the local timers. So far we use the SP804 on the RealView
and Versatile Express boards but we could, at some point, move to the
global timer on A9.

-- 
Catalin
