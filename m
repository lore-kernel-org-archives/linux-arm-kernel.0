From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Aug 2017 15:32:24 +0100
Subject: [PATCHv2 1/7] arm64: Add ASM_BUG()
In-Reply-To: <20170809132131.GB29494@leverpostej>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
 <1501093110-3844-2-git-send-email-mark.rutland@arm.com>
 <20170808153112.GF19207@leverpostej>
 <20170808155853.ropux7lxk6rgbd2r@armageddon.cambridge.arm.com>
 <20170808161050.GH19207@leverpostej>
 <20170809100734.oecy3xq7wwg5ixpd@armageddon.cambridge.arm.com>
 <20170809132131.GB29494@leverpostej>
Message-ID: <20170809143223.aik76c6m3bnzfssf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 02:21:31PM +0100, Mark Rutland wrote:
> On Wed, Aug 09, 2017 at 11:07:35AM +0100, Catalin Marinas wrote:
> > On Tue, Aug 08, 2017 at 05:10:51PM +0100, Mark Rutland wrote:
> > > On Tue, Aug 08, 2017 at 04:58:53PM +0100, Catalin Marinas wrote:
> > > > I'll pull arm64/exception-stack into for-next/core (I haven't got to the
> > > > vmap-stack series yet).
> > > 
> > > If you could hold off for a day, I'd like to make one final change and prevent
> > > use of the final record's LR value, where FP is NULL, since that LR isn't
> > > meaningful, and makes the backtrace look weird:
> > > 
> > > [ 2785.650646] [<ffff000008082cb0>] el0_svc_naked+0x24/0x28
> > > [ 2785.656016] [<0000ffffaf717554>] 0xffffaf717554
> > > 
> > > Otherwise, I can do that as a fixup.
> > 
> > I'll hold off, I haven't pushed the for-next/core branch out yet.
> 
> I've pushed out an updated arm64/exception-stack branch. The HEAD should
> be:
> 
>   31e43ad3b74a5d7b ("arm64: unwind: remove sp from struct stackframe")
> 
> That should have tvhe ASM_BUG() fix, and the below diff folded into the
> pt_regs patch, to ensure that backtraces don't use user-controlled PCs
> or idmap aliases of startup code.
> 
> If you'd like, I can send the updated series as a v3.

No need to, I'll just pull the branch.

Thanks.

-- 
Catalin
